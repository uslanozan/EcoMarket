import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/core/utils/logger.dart';
import 'package:ecomarket/core/utils/parser.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/presentation/providers/gemini_provider.dart';
import 'package:ecomarket/presentation/screens/improve_product_screen.dart';
import 'package:ecomarket/presentation/screens/new_ideas_screen.dart';
import 'package:ecomarket/presentation/widgets/doodle_background.dart';
import 'package:ecomarket/presentation/widgets/idea_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ImproveProductResult extends StatefulWidget {
  const ImproveProductResult({super.key});

  @override
  State<ImproveProductResult> createState() => _ImproveProductResultState();
}

//todo: gemini'den dönen sonuçları regexleyecek fonksiyon yazılacak ve ayrı cardlarda gösterilecek

class _ImproveProductResultState extends State<ImproveProductResult> {
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

      // UI build edildikten sonra çağırılır
      // Burada UI hazır olmadan bilgiyi alma ve onu text içine gömme gibi bir durum olmaması için kullanılıyor
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Fonksiyonu sadece bir kez çağırıyoruz
        _geminiProvider.improveProduct(
            productName: global_ecoImproveAnswers['name'] ?? '-',
            productDescription: global_ecoImproveAnswers['description'] ?? '-',
            currentMaterials: global_ecoImproveAnswers['material'] ?? '-',
            targetMarket: global_ecoImproveAnswers['targetCountry'] ?? '-',
            answerLanguage: global_language,
            fallBackText: AppLocalizations.of(context)!.ecoProductFallBack);
      });
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final geminiProvider = context.watch<GeminiProvider>();
    /*
    final intro = !geminiProvider.isLoading ? parseIntro(output: geminiProvider.newIdeas) : '';
    final ideas = !geminiProvider.isLoading ? parseIdeas(output: geminiProvider.newIdeas) : {};

    logPrint(logTag: "parserLog: ",logMessage: "$ideas");
    logPrint(logTag: "parserLog: ",logMessage: intro);
     */
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DoodleBackground(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 24,top: 24,left: 3,right: 3),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text(
                AppLocalizations.of(context)!.ecoProductIsDone,
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
                      Text(
                        geminiProvider.improveProductResult,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                      // Fikir kartları
                      //... bir iterable içindeki elemanları başka bir koleksiyonun içine serpiştirir
                      /*
                      ...ideas.entries.map((entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: IdeaCart(
                          title: entry.key,
                          content: entry.value,
                        ),
                      )),
                       */
                    ],
                  ),


                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (geminiProvider.improveProductResult.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(AppLocalizations.of(context)!.copyError)),
                        );
                      } else {
                        Clipboard.setData(ClipboardData(text: geminiProvider.improveProductResult));
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ImproveProduct()));
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
