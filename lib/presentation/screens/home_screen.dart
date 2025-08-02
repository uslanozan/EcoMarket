import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/presentation/screens/ecobot_chat.dart';
import 'package:ecomarket/presentation/screens/market_research.dart';
import 'package:ecomarket/presentation/screens/new_ideas.dart';
import 'package:ecomarket/presentation/widgets/ecobot_suggestion.dart';
import 'package:ecomarket/presentation/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';
import 'package:ecomarket/presentation/providers/gemini_provider.dart';
import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/core/utils/text_highlight.dart';

//todo: dil ve günlük öneri kısmı tamamlandı fakat fazla API isteğinden ötürü cache ve 24 saat mekanizması test edilmedi
//todo: NOT!!!! otomatik request atılmasın diye gemini_provider'dan dailySuggest kısmını şimdilik kapattım

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //------------------------FUNCTIONS----------------------
  // EcoBot Info mesajı
  void _showEcoBotInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.ecoBotInfoLabel,
          style: TextStyle(
            color: AppTheme.primaryGreenLight,
          ),
        ),
        content: SingleChildScrollView(
          child: RichText(
            text: highlightWordsInText(
              text: AppLocalizations.of(context)!.ecoBotInfoMessage,
              highlights: global_language == "Turkish"
                  ? global_trHighlightWords
                  : global_enHighlightWords,
              normalStyle: Theme.of(context).textTheme.bodyMedium!,
              highlightStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.gotIt),
          ),
        ],
      ),
    );
  }

  //------------------------FUNCTIONS END------------------

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
      geminiProvider.getDailySuggestion(
          answerLanguage: global_language,
          fallBackText: AppLocalizations.of(context)!.noSuggestion);

      print(
          'GLOBAL_LANGUAGE:$global_language and LANGUAGE_CODE: ${localeProvider.locale.languageCode}');
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
            onPressed: () async {
              localeProvider.setLocale(
                localeProvider.locale.languageCode == 'tr'
                    ? const Locale('en')
                    : const Locale('tr'),
              );

              if (geminiProvider.dailySuggestion.isEmpty ?? true) {
                await geminiProvider.getDailySuggestion(
                    answerLanguage: global_language,
                    fallBackText: AppLocalizations.of(context)!.noSuggestion);
              } else {
                await geminiProvider.translateSuggestion(
                    newLanguage: global_language,
                    fallBackText: AppLocalizations.of(context)!.noSuggestion);
              }
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
                  //todo: burası dinamikleşecek user'a göre.
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
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => NewIdeas())
                            );
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MarketResearch()));
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
                  const SizedBox(height: 5),
                  Center(child: Text(local.cardInfo,style: TextTheme.of(context).bodySmall,)),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: AppTheme.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: EcoBotSuggestion(
                      local: local,
                      geminiProvider: geminiProvider,
                    ),
                  ),
                  Center(child: Text(local.talkToEcoBot)),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EcoBotChat()),
                        );
                        // TODO: EcoBot chat page
                        print("EcoBot tıklandı!");
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          'assets/images/ecobot_default.png',
                          height: 250,
                          width: 250,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          WidgetStateProperty.all(Colors.transparent),
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                    ),
                    onPressed: () {
                      _showEcoBotInfo(context);
                    },
                    child: Text(
                      local.ecoBotInfoLabel,
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
                    child:
                        const Icon(Icons.local_shipping, color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Showing graphs page
                    },
                    child:
                        const Icon(Icons.bar_chart_sharp, color: Colors.white),
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
