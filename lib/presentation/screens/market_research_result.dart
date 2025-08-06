import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/core/utils/logger.dart';
import 'package:ecomarket/core/utils/parser.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/presentation/providers/gemini_provider.dart';
import 'package:ecomarket/presentation/screens/market_research_screen.dart';
import 'package:ecomarket/presentation/widgets/doodle_background.dart';
import 'package:ecomarket/presentation/widgets/idea_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MarketResearchResult extends StatefulWidget {
  const MarketResearchResult({super.key});

  @override
  State<MarketResearchResult> createState() => _MarketResearchResultState();
}

class _MarketResearchResultState extends State<MarketResearchResult> {
  // late dememizin sebei değişken şuan atanmayacak ama null olmayacak demek
  // bunu demezsek GeminiProvider? _geminiProvider olarak tanımlamak gerek
  // ve bundan sonra her yerde ? kontrolü yapmak gerekir
  late GeminiProvider _geminiProvider;
  bool _isInitialized = false;


  // initState BuildContext'e erişilebilir gibi görünse de widget tree'ye tam bağlanmamıştır
  // bu yüzden context'e bağlı providerlar hata verebilir
  // ama didChangeDependencies widget ve context tamamen bağlandığında çalışır
  // bu yüzden context'e bağlı şeyler için daha güvenlidir
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
    //todo: duruma göre parse edicez bekleyebilir şimdilik

    //todo: burası yapılacak
    final sections = !geminiProvider.isLoading ? parseIdeas(output: geminiProvider.marketResearchResult) : {};
    logPrint(logTag: 'sections',logMessage: '$sections');
    Map<String, String> listedSections = {};

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DoodleBackground(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 24,top: 24,left: 3,right: 3),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.marketResearchIsDone,
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
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(geminiProvider.marketResearchResult),

                      ...sections.entries.map((entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: IdeaCard(
                          title: entry.key,
                          content: entry.value,
                        ),
                      )),
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
                    icon: const Icon(Icons.copy),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MarketResearch()));
                    },
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
}
