import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/presentation/screens/ecobot_chat.dart';
import 'package:ecomarket/presentation/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/gemini_provider.dart';
import 'package:ecomarket/core/globals/globals.dart';

//todo: dil değiştiğinde Günlük öneri de değişmeli. Ayrıca bunlar 24 saat boyunca sabit kalmalı
//todo: tema değiştirmeye ilk bastığımda hiçbir şey olmuyor 2. bastığımda tema değişiyor debug edilmeli

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Sayfa açılır açılmaz provider'daki günlük öneriyi çağır
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final localeProvider = context.read<LocaleProvider>();

      // Burada global_language'ı güncelleyebilirsin:
      if (localeProvider.locale.languageCode == 'tr') {
        global_language = "Turkish";
      } else {
        global_language = "English";
      }

      final geminiProvider = context.read<GeminiProvider>();
      geminiProvider.getDailySuggestion(answerLanguage: global_language);

      print('GLOBAL_LANGUAGE:$global_language and LANGUAGE_CODE: ${localeProvider.locale.languageCode}');
    });

  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final localeProvider = context.read<LocaleProvider>();
    final themeProvider = context.watch<ThemeModeProvider>();
    final geminiProvider = context.watch<GeminiProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(local.appTitle),
        actions: [
          IconButton(
            icon: ShaderMask(
              shaderCallback: (bounds) {
                final isTurkish = localeProvider.locale.languageCode == 'tr';
                return isTurkish
                    ? AppTheme.turkishGradient.createShader(bounds)
                    : AppTheme.englishGradient.createShader(bounds);
              },
              child: const Icon(Icons.language, size: 24, color: Colors.white),
            ),
            onPressed: () {
              localeProvider.setLocale(
                localeProvider.locale.languageCode == 'tr'
                    ? const Locale('en')
                    : const Locale('tr'),
              );
            },
          ),
          IconButton(
            icon: themeProvider.getCurrentThemeMode() == ThemeMode.light
                ? const Icon(Icons.brightness_6)
                : const Icon(Icons.brightness_2_rounded),
            onPressed: () {
              context.read<ThemeModeProvider>().toggleTheme();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Scrollable içerik
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Center(child: Text('${local.homeWelcome} Ozan')),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        InfoCard(
                          title: local.newIdeasTitle,
                          subtitle: local.newIdeasSubtitle,
                          icon: Icons.lightbulb,
                          onTap: () {
                            // TODO: Yeni fikirler page
                          },
                        ),
                        const SizedBox(width: 20),
                        InfoCard(
                          title: local.ecoProductTitle,
                          subtitle: local.ecoProductSubtitle,
                          icon: Icons.recycling,
                          onTap: () {
                            // TODO: More Eco product page
                          },
                        ),
                        const SizedBox(width: 20),
                        InfoCard(
                          title: local.marketResearchTitle,
                          subtitle: local.marketResearchSubtitle,
                          icon: Icons.sell,
                          onTap: () {
                            // TODO: Pazar araştırması page
                          },
                        ),
                        const SizedBox(width: 20),
                        InfoCard(
                          title: local.userFeedbackTitle,
                          subtitle: local.userFeedbackSubtitle,
                          icon: Icons.star,
                          onTap: () {
                            // TODO: User feedback page
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: AppTheme.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.auto_awesome, size: 30, color: Colors.white),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    local.ecoBotSuggestion,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),

                                  // Burada günlük öneriyi gösteriyoruz
                                  geminiProvider.isLoading
                                      ? CircularProgressIndicator(color: Colors.white70)
                                      : Text(
                                    geminiProvider.response.isEmpty ? 'Yükleniyor...' : geminiProvider.response,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Center(child: Text(local.talkToEcoBot)),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        // TODO: EcoBot chat page
                        print("EcoBot tıklandı!");
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          'assets/ecobot_default.png',
                          height: 250,
                          width: 250,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    onPressed: () {
                      // TODO: What's EcoBot pop-up
                    },
                    child: Text(
                      local.ecoBotInfo,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              color: AppTheme.primaryGreenLight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () {
                      // TODO: Following product page
                    },
                    child: const Icon(Icons.local_shipping, color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Showing graphs page
                    },
                    child: const Icon(Icons.bar_chart_sharp, color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Buy page?
                    },
                    child: const Icon(Icons.shopping_cart, color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Profile page
                    },
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
