import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/mock/mock_processes.dart';
import 'package:ecomarket/core/models/process.dart';
import 'package:ecomarket/core/utils/logger.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  // Pie chart için
  List<PieChartData> chartMostSold = [];
  // Stacked bar için (sizin ChartData yapınıza uygun olarak)
  List<ChartDataForStackedBar> chartStatusData = []; // Yeni isim
  // Bar chart için
  List<CustomerChartData> top5Customers = [];

  @override
  void initState() {
    super.initState();
    _preparePieChartData();
    _prepareStackedBarChartData();
    _prepareCustomerChartData();
  }

  void _prepareCustomerChartData() {
    final Map<String, num> customerQuantityMap = {};

    for (var process in mockProcesses) {
      final customerName = process.customer.name;
      final quantity = process.quantity;

      customerQuantityMap.update(
        customerName,
            (value) => value + quantity,
        ifAbsent: () => quantity,
      );
    }

    // Map'i listeye dönüştür
    customerQuantityMap.forEach((name, quantity) {
      top5Customers.add(CustomerChartData(name, quantity));
    });

    // En çok alım yapana göre sırala
    top5Customers.sort((a, b) => b.totalQuantity.compareTo(a.totalQuantity));

    // İlk 5 müşteriyi al
    top5Customers = top5Customers.take(5).toList();
  }

  void _preparePieChartData() {
    chartMostSold.clear();
    final Map<String, double> salesCount = {};

    for (var process in mockProcesses) {
      final productName = process.product.name;
      salesCount.update(
        productName,
            (value) => value + process.quantity,
        ifAbsent: () => process.quantity.toDouble(),
      );
    }

    int colorIndex = 0;
    salesCount.forEach((productName, quantity) {
      final color = Colors.primaries[colorIndex % Colors.primaries.length];
      chartMostSold.add(PieChartData(productName, quantity, color));
      colorIndex++;
    });
  }
  void _prepareStackedBarChartData() {
    chartStatusData.clear();
    final Map<String, Map<String, int>> statusMap = {};

    for (var process in mockProcesses) {
      final productName = process.product.name;
      final status = process.status; // ProcessStatus enum değeri

      statusMap.putIfAbsent(productName, () => {"delivered": 0, "cancelled": 0});

      // Mantıksal hata düzeltildi: "pending" yerine "delivered" kontrolü yapılıyor.
      if (status == ProcessStatus.delivered) {
        statusMap[productName]!["delivered"] =
            (statusMap[productName]!["delivered"] ?? 0) + process.quantity;
      } else if (status == ProcessStatus.cancelled) {
        statusMap[productName]!["cancelled"] =
            (statusMap[productName]!["cancelled"] ?? 0) + process.quantity;
      }
    }

    statusMap.forEach((productName, counts) {
      logPrint(logTag: "stackedBarChart :",logMessage: "Ürün: $productName   - Teslim Edildi: ${counts["delivered"] ?? 0} adet   - İptal Edildi: ${counts["cancelled"] ?? 0} adet");


      chartStatusData.add(
        ChartDataForStackedBar(
          productName,
          (counts["delivered"] ?? 0).toDouble(),
          (counts["cancelled"] ?? 0).toDouble(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text(AppLocalizations.of(context)!.graphTitle)),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.only(left: 10,right: 10,),
        child: Column(
          children: [
            // 🥧 Pie Chart: En çok satılan ürünler
            SizedBox(
              height: 400,
              width: double.infinity,
              child: SfCircularChart(
                title: ChartTitle(
                  text: AppLocalizations.of(context)!.soldProductGraph,
                  textStyle: TextTheme.of(context).titleLarge,
                ),
                legend: const Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                series: <CircularSeries>[
                  PieSeries<PieChartData, String>(
                    dataSource: chartMostSold,
                    pointColorMapper: (PieChartData data, _) => data.color,
                    xValueMapper: (PieChartData data, _) => data.prodName,
                    yValueMapper: (PieChartData data, _) => data.quantity,
                    dataLabelMapper: (PieChartData data, _) =>
                    '${data.quantity.toInt()}',
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                      connectorLineSettings:
                      ConnectorLineSettings(type: ConnectorType.curve),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Divider(),
            const SizedBox(height: 30),

            // 📊 Stacked Bar: Pending / Cancelled
            SizedBox(
              height: 400,
              width: double.infinity,
              child: SfCartesianChart(
                title: ChartTitle(
                  text: AppLocalizations.of(context)!.productStatusBar,
                  textStyle: TextTheme.of(context).titleLarge,
                ),
                legend: const Legend(isVisible: true),

                primaryXAxis: CategoryAxis(
                  isVisible: false, // X ekseni etiketlerini gizler
                ),
                series: <CartesianSeries>[
                  StackedBar100Series<ChartDataForStackedBar, String>( // Yeni model adı
                    dataSource: chartStatusData,
                    xValueMapper: (ChartDataForStackedBar data, _) => data.productName,
                    yValueMapper: (ChartDataForStackedBar data, _) => data.isDelivered,
                    name: AppLocalizations.of(context)!.deliveredStatus, // Legend için isim
                    width: 0.8,
                    spacing: 0.2,
                    color: AppTheme.processStatusColors[ProcessStatus.delivered],
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside, // Etiketi çubuğun içine yerleştirir
                      builder: (data, point, series, pointIndex, seriesIndex) {
                        // Sadece ilk seride (Pending) ürün adını gösteririz.
                        return Text(
                          (data as ChartDataForStackedBar).productName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),

                  ),
                  StackedBar100Series<ChartDataForStackedBar, String>( // Yeni model adı
                    dataSource: chartStatusData,
                    xValueMapper: (ChartDataForStackedBar data, _) => data.productName,
                    yValueMapper: (ChartDataForStackedBar data, _) => data.isCancelled,
                    name: AppLocalizations.of(context)!.cancelledStatus, // Legend için isim
                    width: 0.8,
                    spacing: 0.2,
                    color: AppTheme.processStatusColors[ProcessStatus.cancelled],
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),
            Divider(),
            const SizedBox(height: 30),

            // 📊 Yatay Bar Chart: En Çok Alım Yapan Müşteriler
            SizedBox(
              height: 400,
              width: double.infinity,
              child: SfCartesianChart(
                title: ChartTitle(text: AppLocalizations.of(context)!.top5customers,textStyle: TextTheme.of(context).titleLarge,),
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                series: <CartesianSeries>[
                  BarSeries<CustomerChartData, String>(
                    dataSource: top5Customers,
                    xValueMapper: (CustomerChartData data, _) => data.customerName,
                    yValueMapper: (CustomerChartData data, _) => data.totalQuantity,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    color: AppTheme.primaryGreen,
                  )
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}

// Pie chart için model
class PieChartData {
  PieChartData(this.prodName, this.quantity, [this.color]);
  final String prodName;
  final double quantity;
  final Color? color;
}

// Stacked Bar chart için model
class ChartDataForStackedBar { // Daha açıklayıcı bir isim verdim
  ChartDataForStackedBar(this.productName, this.isDelivered, this.isCancelled);
  final String productName;
  final num isDelivered; // Num tipini kullanabiliriz
  final num isCancelled; // Num tipini kullanabiliriz
}
// Müşteri verileri için model
class CustomerChartData {
  CustomerChartData(this.customerName, this.totalQuantity);
  final String customerName;
  final num totalQuantity;
}