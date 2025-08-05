import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/mock/mock_processes.dart';
import 'package:ecomarket/core/models/customer.dart';
import 'package:ecomarket/core/models/process.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// Bir enum ya da sınıfı değiştirmeden yeni özellik atamamızı sağlar
// Burada ProcessStatus enumuna color özelliği ekledik
extension ProcessStatusIcon on ProcessStatus {
  IconData get icon {
    switch (this) {
      case ProcessStatus.delivered:
        return Icons.check_circle;
      case ProcessStatus.shipped:
        return Icons.local_shipping;
      case ProcessStatus.pending:
        return Icons.access_time;
      case ProcessStatus.cancelled:
        return Icons.cancel;
    }
  }
}


class ProcessesScreen extends StatelessWidget {
  const ProcessesScreen({super.key});


  void _showCustomerDetail(BuildContext context, Customer customer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '${customer.name} ${customer.surName}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryGreenLight
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(customer.avatarUrl),
              ),
              const SizedBox(height: 16.0),
              ListTile(
                leading: Icon(Icons.email,color: AppTheme.primaryGreen,),
                title: Text(AppLocalizations.of(context)!.email),
                subtitle: Text(customer.email),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.phone,color: AppTheme.primaryGreen),
                title: Text(AppLocalizations.of(context)!.phone),
                subtitle: Text(customer.phone),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.location_on,color: AppTheme.primaryGreen),
                title: Text(AppLocalizations.of(context)!.address),
                subtitle: Text(
                  customer.addressList.isNotEmpty
                      ? customer.addressList.first
                      : AppLocalizations.of(context)!.noAddress,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.close),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.processesLabel),
      ),
      body: ListView.builder(
        itemCount: mockProcesses.length,
        itemBuilder: (context, index) {
          final process = mockProcesses[index];
          final customer = process.customer;
          final product = process.product;
          Color statusColor = AppTheme.processStatusColors[process.status] ?? Colors.grey;

          return GestureDetector(
            onTap: (){
              _showCustomerDetail(context,customer);
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Status and ID
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  process.status.icon,
                                  size: 16,
                                  color: statusColor,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  process.status.toString().split('.').last.toUpperCase(),
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            )
                        ),
                        Text(
                          '#${process.id}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),

                    // Product and Customer Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            product.imageUrls.first,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        // Product and Customer Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                '${AppLocalizations.of(context)!.customerLabel}: ${customer.name} ${customer.surName}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                '${AppLocalizations.of(context)!.quantityLabel}: ${process.quantity}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                '${AppLocalizations.of(context)!.dateLabel}: ${process.date.toLocal().toString().split(' ')[0]}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
