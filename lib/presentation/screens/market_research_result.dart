import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/core/utils/logger.dart';
import 'package:ecomarket/core/utils/parser.dart'; // Bu dosyanın içeriği JSON parsing için güncellenmeli veya buradaki parsing kullanılmalı
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/presentation/providers/gemini_provider.dart';
import 'package:ecomarket/presentation/screens/market_research_screen.dart';
import 'package:ecomarket/presentation/widgets/doodle_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:convert'; // JSON işlemleri için eklendi

class MarketResearchResult extends StatefulWidget {
  const MarketResearchResult({super.key});

  @override
  State<MarketResearchResult> createState() => _MarketResearchResultState();
}

class _MarketResearchResultState extends State<MarketResearchResult> {
  late GeminiProvider _geminiProvider;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _geminiProvider = context.read<GeminiProvider>();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _geminiProvider.doMarketResearch(
          productIdea: global_marketResearchAnaswers['explanation'] ?? '_',
          targetCountries: global_marketResearchAnaswers['targetCountry'] ?? '_',
          answerLanguage: global_language,
          fallBackText: AppLocalizations.of(context)!.marketResearchFallBack,
        );
      });
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final geminiProvider = context.watch<GeminiProvider>();

    Map<String, dynamic>? parsedData;
    String? errorMessage;
    if (!geminiProvider.isLoading && geminiProvider.marketResearchResult.isNotEmpty) {
      String rawResponse = geminiProvider.marketResearchResult;
      String jsonString = rawResponse; // Varsayılan olarak tüm yanıtı al

      // 1. Adım: Yanıtın Markdown kod bloğu içinde olup olmadığını kontrol et ve ayıkla
      final jsonBlockRegex = RegExp(r'```json\s*([\s\S]*?)\s*```');
      final match = jsonBlockRegex.firstMatch(rawResponse);

      if (match != null && match.group(1) != null) {
        // Eğer Markdown kod bloğu içinde ise, sadece JSON kısmını al
        jsonString = match.group(1)!;
      } else {
        // 2. Adım: Eğer Markdown içinde değilse, yanıtın doğrudan JSON olup olmadığını kontrol et
        // Yanıtın '{' ile başlaması beklenir. Başlamıyorsa, geçerli bir JSON değildir.
        if (!jsonString.trim().startsWith('{')) {
          errorMessage = AppLocalizations.of(context)!.apiResponseNotJson; // Yeni metin
          logPrint(logTag: "JSON_Parse_Error_MarketResearch", logMessage: "API yanıtı geçerli bir JSON formatında değil.\nYanıt: $rawResponse");
          // parsedData null kalacak, böylece hata mesajı gösterilecek
          // Hata durumunda daha fazla işlem yapmadan burada dönebiliriz.
          // Ancak hata mesajını göstermek için build metodunun sonuna kadar gitmeliyiz.
        }
      }

      // Sadece errorMessage null ise JSON ayrıştırmayı dene
      if (errorMessage == null) {
        try {
          parsedData = json.decode(jsonString);
        } catch (e) {
          errorMessage = "${AppLocalizations.of(context)!.jsonParsingFailed}: $e\n${AppLocalizations.of(context)!.problematicPart}: $jsonString"; // Yeni metinler
          logPrint(logTag: "JSON_Parse_Error_MarketResearch", logMessage: errorMessage);
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DoodleBackground(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 24, top: 24, left: 16, right: 16),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text(
                AppLocalizations.of(context)!.marketResearchIsDone,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.primaryGreenLight,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: geminiProvider.isLoading
                      ? const Center(
                    child: CircularProgressIndicator(color: Colors.white70),
                  )
                      : errorMessage != null
                      ? Center(
                    child: Text(
                      errorMessage,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                  )
                      : parsedData == null
                      ? Center(
                    child: Text(
                      AppLocalizations.of(context)!.marketResearchFallBack,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Pazar Talebi
                      _buildMarketResearchInfoCard(
                        context,
                        AppLocalizations.of(context)!.marketDemand,
                        parsedData!["Market Demand"] ?? AppLocalizations.of(context)!.notAvailable,
                        icon: Icons.trending_up,
                      ),
                      const SizedBox(height: 16),

                      // Hedef Müşteri Segmentleri
                      _buildMarketResearchInfoCard(
                        context,
                        AppLocalizations.of(context)!.targetCustomerSegments,
                        parsedData!["Target Customer Segments"] ?? AppLocalizations.of(context)!.notAvailable,
                        icon: Icons.people,
                      ),
                      const SizedBox(height: 16),

                      // Rekabet Ortamı
                      _buildMarketResearchInfoCard(
                        context,
                        AppLocalizations.of(context)!.competitiveLandscape,
                        parsedData!["Competitive Landscape"] ?? AppLocalizations.of(context)!.notAvailable,
                        icon: Icons.business,
                      ),
                      const SizedBox(height: 16),

                      // Benzer Ürünler ve Pazaryerleri
                      _buildMarketResearchInfoCard(
                        context,
                        AppLocalizations.of(context)!.similarProductsAndMarketplaces,
                        parsedData!["Similar Products & Marketplaces"] ?? AppLocalizations.of(context)!.notAvailable,
                        icon: Icons.shopping_bag,
                      ),
                      const SizedBox(height: 16),

                      // Fiyat Aralığı
                      _buildMarketResearchInfoCard(
                        context,
                        AppLocalizations.of(context)!.priceRange,
                        parsedData!["Price Range"] ?? AppLocalizations.of(context)!.notAvailable,
                        icon: Icons.attach_money,
                      ),
                      const SizedBox(height: 16),

                      // Trendler ve Büyüme Modeli
                      _buildMarketResearchInfoCard(
                        context,
                        AppLocalizations.of(context)!.trendsAndGrowthPattern,
                        parsedData!["Trends and Growth Pattern"] ?? AppLocalizations.of(context)!.notAvailable,
                        icon: Icons.show_chart,
                      ),
                      const SizedBox(height: 16),

                      // Riskler ve Sınırlamalar
                      _buildMarketResearchInfoCard(
                        context,
                        AppLocalizations.of(context)!.risksAndLimitations,
                        parsedData!["Risks and Limitations"] ?? AppLocalizations.of(context)!.notAvailable,
                        icon: Icons.warning,
                        iconColor: Colors.orangeAccent,
                      ),
                      const SizedBox(height: 16),

                      // Mevcut Ürünler ve Fiyatlar (Daha karmaşık yapı)
                      _buildExistingProductsCard(context, parsedData!["Existing Products and Prices"]),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (geminiProvider.marketResearchResult.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(AppLocalizations.of(context)!.copyError)),
                        );
                      } else {
                        Clipboard.setData(ClipboardData(text: geminiProvider.marketResearchResult));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(AppLocalizations.of(context)!.copied)),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy, color: Colors.white70),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MarketResearch()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreenLight,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.restart),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Genel bilgi kartı oluşturucu
  Widget _buildMarketResearchInfoCard(BuildContext context, String title, String content, {IconData? icon, Color? iconColor}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) Icon(icon, color: iconColor ?? AppTheme.primaryGreenLight),
                if (icon != null) const SizedBox(width: 8),
                Expanded( // Başlığın taşmasını engellemek için Expanded eklendi
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreenDark,
                    ),
                    overflow: TextOverflow.ellipsis, // Gerekirse metni kısalt
                  ),
                ),
              ],
            ),
            const Divider(),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // Mevcut Ürünler ve Fiyatlar Kartı oluşturucu
  Widget _buildExistingProductsCard(BuildContext context, Map<String, dynamic>? data) {
    if (data == null) {
      return _buildMarketResearchInfoCard(
        context,
        AppLocalizations.of(context)!.existingProductsAndPrices,
        AppLocalizations.of(context)!.notAvailable,
        icon: Icons.store,
      );
    }

    final bool similarProductsAvailable = data["Similar Products Available"] ?? false;
    final List<dynamic> brands = data["Brands/Sellers"] ?? [];
    final Map<String, dynamic> priceRanges = data["Price Ranges"] ?? {};

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.store, color: AppTheme.primaryGreenLight),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.existingProductsAndPrices,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGreenDark,
                  ),
                ),
              ],
            ),
            const Divider(),
            Text(
              '${AppLocalizations.of(context)!.similarProductsAvailable}: ${similarProductsAvailable ? AppLocalizations.of(context)!.yes : AppLocalizations.of(context)!.no}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            if (brands.isNotEmpty) ...[
              Text(
                AppLocalizations.of(context)!.brandsSellers,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTheme.primaryGreen),
              ),
              const SizedBox(height: 4),
              ...brands.map((brand) => Text(
                '• $brand',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87),
              )).toList(),
            ],
            if (priceRanges.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.priceRanges,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTheme.primaryGreen),
              ),
              const SizedBox(height: 4),
              ...priceRanges.entries.map((entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  '${entry.key}: ${entry.value}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87),
                ),
              )).toList(),
            ],
            if (!similarProductsAvailable && brands.isEmpty && priceRanges.isEmpty)
              Text(
                AppLocalizations.of(context)!.noSpecificProductInfo,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic, color: Colors.black54),
              ),
          ],
        ),
      ),
    );
  }
}
