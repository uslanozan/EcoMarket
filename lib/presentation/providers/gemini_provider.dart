import 'package:ecomarket/core/cache/daily_suggestion_cache.dart';
import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiProvider extends ChangeNotifier {

  //todo: enum açarak gemini status kontrol etme eklenebilir ama şuan biraz gereksiz
  //todo: Fonksiyonlara saçma şeyler yazılırsa prompt sapıtabilir bu eklenebilir (improve harici denenmedi):
  //todo: Do not generate any fallback messages, warnings, or hypothetical examples.
  final Gemini _gemini = Gemini.instance;

  final cache = DailySuggestionCache();

  // prompt results
  // günlük öneri
  String _dailySuggestion= '';
  String get dailySuggestion => _dailySuggestion;

  // yeni fikirler
  String _newIdeasResult= '';
  String get newIdeasResult => _newIdeasResult;

  // market araştırması
  String _marketResearchResult = '';
  String get marketResearchResult => _marketResearchResult;

  // daha çevreci yapma
  String _improveProductResult= '';
  String get improveProductResult => _improveProductResult;

  // yorumları özetleme
  String _summarizeCommentsResult = '';
  String get summarizeCommentsResult => _summarizeCommentsResult;

  // normal prompt için olacak
  String _response = '';
  String get response => _response;


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;




  // Genel prompt gönderme fonksiyonu (isteğe bağlı)
  Future<void> sendPrompt({
    required String prompt,
    required String fallBackText,
}) async {
    _setLoading();
    try {
      final result = await _gemini.text(prompt);
      _setResponse(result?.output ?? fallBackText);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Yeni ürün fikirleri için prompt
  Future<void> generateNewProductIdeas({
    //todo: Direkt explanation da eklenebilir
    required String productCategory,
    required String material,
    required String targetCountry,
    required String ecoFriendly,
    required String budget,
    required String answerLanguage, // Direkt UI tarafından gelecek, Turkish ya da English
    required String fallBackText,
  }) async {
    _setLoading();


    logPrint(logTag: "generateNewProductIdeas: ",logMessage: "$productCategory, $material, $targetCountry, $ecoFriendly, $budget, $answerLanguage, $fallBackText");

    final prompt = '''
    Some of the parameters below may be written in Turkish. Please translate them to English before processing the request, and only use the translated versions in your reasoning. If the parameters are empty or meanless, ignore the parameter. 
    Please silently translate them to English before processing the request, and only use the translated versions in your reasoning. Do not include the translated parameters or any explanation in the final output.
    Each idea must start with a '+' symbol followed by a space (e.g., '+ Idea title'). Do not use bullet points or numbering. Only use the '+' format.
    Give details for ideas. Before listing the product ideas, generate a short introductory sentence that summarizes the budget, target market, product category, and eco-friendliness level using natural language.
    Important: Do not include any content (descriptions or explanations) on the same line as the idea title. The line starting with + should contain only the title. Add the idea’s content in the lines below.


Parameters:
- Product category: $productCategory
- Material preference: $material
- Target country: $targetCountry
- Eco-friendly: $ecoFriendly
- Budget: $budget

Generate innovative and $ecoFriendly new product ideas targeting this market: $targetCountry.

Use the given $material and $productCategory preferences. Make sure the idea aligns with the concept of sustainability if $ecoFriendly is marked as "yes".
The price range may be cheap, expensive or something else according to $budget.

Answer in $answerLanguage.

  ''';

    logPrint(logTag: "generateNewProductIdeas: ",logMessage: "Prompt is: \n $prompt");

    try {
      final result = await _gemini.text(prompt);
      logPrint(logTag: "generateNewProductIdeas: ",logMessage: "Result is: \n $result");
      _setNewIdeas(result?.output ?? fallBackText);
    } catch (e) {
      _setError(e.toString());
      logPrint(logTag: "generateNewProductIdeas: ",logMessage: "Result Error: \n $e");
    }
  }


  //todo: result Instance of 'Candidate' dönüyor ama output geliyor. Araştırılacak
  //todo: sebebi promptta internet araştırması istemem olabilir ?
  // Pazar araştırması
  Future<void> doMarketResearch({
    required String productIdea,
    required String targetCountries,
    required String answerLanguage, // Direkt UI tarafından gelecek, Turkish ya da English
    required String fallBackText,
  }) async {
    _setLoading();

    logPrint(logTag: "doMarketResearch: ",logMessage: "$productIdea, $targetCountries, $answerLanguage, $fallBackText");


    final prompt = '''
Some of the parameters below may be written in Turkish. Please translate them to English before processing the request, and only use the translated versions in your reasoning. 
If the parameters are empty or meaningless, ignore them. Please silently translate them before reasoning and use only the translated versions. 
Do not include the translated parameters or any explanation in the final output. Start directly from the first section below.
Each section title must start with a '+' (e.g., +Market Demand+) and must not be numbered.
If listing subitems (e.g., customer segments), write each item on a new line starting with ++ and ending with ++, followed by a single, concise explanatory sentence.
Use paragraph breaks (\n\n) between sections for readability.

Parameters:
- Product idea: $productIdea
- Target countries/markets: $targetCountries

Conduct a comprehensive market research report for the product idea "$productIdea" targeting the region: $targetCountries.

Include the following sections:
+Market Demand+: Is this product in demand in the target market?

+Target Customer Segments+: What types of customers are likely to buy it?

+Competitive Landscape+: Who are the key competitors, and how saturated is the market?

+Similar Products & Marketplaces+: Are there similar products currently available? Through which platforms or marketplaces are they being sold?

+Price Range+: What is the general price range of similar products?

+Trends and Growth Patterns+: Are there any trends or growth patterns related to this product?

+Risks and Limitations+: Any potential risks or limitations to consider?

At the end, add one final section:

+Existing Products and Prices+:
- Mention whether similar products are currently available on the market
- List a few existing brands or sellers (if any)
- Provide their approximate price ranges

Ensure the analysis is practical, realistic, and actionable for an entrepreneur or product designer.

Translate all section titles (e.g., +Market Demand+) to $answerLanguage before generating the output. Keep the '+' format and capitalization consistent with the answer language.
Answer in $answerLanguage.
''';

    logPrint(logTag: "doMarketResearch: ",logMessage: "Prompt is: \n $prompt");


    try {
      final result = await _gemini.text(prompt);
      logPrint(logTag: "doMarketResearch: ",logMessage: "Result is: \n ${result.toString()}");
      _setMarketResearch(result?.output ?? fallBackText);
    } catch (e) {
      _setError(e.toString());
      logPrint(logTag: "doMarketResearch: ",logMessage: "Result Error: \n $e");
    }
  }


  // Ürünü daha çevreci hale getirmek için prompt
  //todo: fiyat, kullanıcı yorumları vesaire eklenebilir
  Future<void> improveProduct({
    required String productName,
    required String productDescription,
    required String currentMaterials,
    required String targetMarket,
    required String answerLanguage, // Direkt UI tarafından gelecek, Turkish ya da English
    required String fallBackText,
  }) async {
    _setLoading();

    logPrint(logTag: "improveProduct: ",logMessage: "$productName, $productDescription, $currentMaterials, $targetMarket, $answerLanguage, $fallBackText");


    final prompt = '''
Some of the parameters below may be written in Turkish. Please translate them to English before processing the request, and only use the translated versions in your reasoning.
If the parameters are empty or meaningless, ignore them. Do not generate any fallback messages, warnings, or hypothetical examples. 
Please silently translate them before reasoning and use only the translated versions. 
Each suggestion title must start with a '+' (e.g., +Material Optimization+) and must not be numbered.
If listing subitems (e.g., removing chemicals), write each item on a new line starting with ++ and ending with ++, followed by a single, concise explanatory sentence.
Use paragraph breaks (\n\n) between sections for readability.

Parameters:
- Product name: $productName
- Product description: $productDescription
- Current materials: $currentMaterials
- Target market: $targetMarket

Suggest detailed and practical ways to improve the eco-friendliness of the product described above by optimizing materials, production, packaging, or any other factors. Consider sustainability trends relevant to the target market.

Answer in $answerLanguage.
  ''';

    logPrint(logTag: "improveProduct: ",logMessage: "Prompt is: \n $prompt");


    try {
      final result = await _gemini.text(prompt);
      _setImproveProduct(result?.output ?? fallBackText);
      logPrint(logTag: "improveProduct: ",logMessage: "Result is: \n ${result.toString()}");
    } catch (e) {
      _setError(e.toString());
      logPrint(logTag: "improveProduct: ",logMessage: "Result Error: \n $e");
    }
  }

  // Ürünün kullanıcı yorumlarını analiz eder ve özetler
  Future<void> summarizeUserFeedback({
    required String productName,
    required String userFeedbacks,  // Kullanıcı geri dönüşleri, uzun metin olarak veya birleştirilmiş hali
    required String answerLanguage, // Direkt UI tarafından gelecek, Turkish ya da English
    required String fallBackText,
  }) async {
    _setLoading();

    final prompt = '''
Some of the parameters below may be written in Turkish. Please translate them to English before processing the request, and only use the translated versions in your reasoning. If the parameters are empty or meaningless, ignore them.

Parameters:
- Product name: $productName
- User feedbacks: $userFeedbacks

Please provide a concise and clear summary of the user feedbacks regarding the product above. Highlight positive points, common issues, and suggestions for improvement.

Answer in $answerLanguage.
  ''';

    try {
      final result = await _gemini.text(prompt);
      _setResponse(result?.output ?? fallBackText);
    } catch (e) {
      _setError(e.toString());
    }
  }


  Future<void> getDailySuggestion({
    required String answerLanguage,
    required String fallBackText,
  }) async {
    print('OZAN_LOG: getDailySuggestion started for language: $answerLanguage');
    _setLoading();

    try {
      final cachedSuggestion = await cache.getCachedSuggestion(global_language);
      if (cachedSuggestion != null) {
        _setDailySuggestion(cachedSuggestion);
        return;
      } else {
        print('OZAN_LOG: Cache bulunamadı veya boş');
      }
    } catch (e) {
      print('OZAN_LOG: Cache okuma sırasında hata: $e');
    }

    final prompt = '''
Provide a fresh and innovative daily suggestion related to e-commerce, lifestyle, or sustainability for those engaged in e-commerce. 
The suggestion should be inspiring and useful. It must be at most one sentence.
Answer in $answerLanguage.
''';

    try {
      print('OZAN LOG: Gemini prompt gönderiliyor:\n$prompt');
      final result = await _gemini.text(prompt);
      final suggestion = result?.output?.trim() ?? fallBackText;
      print('OZAN LOG: Gemini cevabı alındı: $suggestion');

      _setDailySuggestion(suggestion);

      try {
        await cache.saveSuggestion(global_language, suggestion);
        print('OZAN LOG: Öneri cache\'e kaydedildi');
      } catch (e) {
        print('OZAN LOG: Cache kaydetme hatası: $e');
      }
    } catch (e) {
      print('OZAN LOG: Gemini API çağrısında hata: $e');
      _setError(e.toString());
    }
  }


  Future<void> translateSuggestion({
    required String newLanguage,
    required String fallBackText,
  }) async {
    print('OZAN_LOG: translateSuggestion started');
    print('OZAN_LOG: Current suggestion: $_dailySuggestion');
    print('OZAN_LOG: Target language: $newLanguage');

    _setLoading();

    final prompt = '''
Translate the following sentence into $newLanguage. Do not change the meaning. Keep it to one sentence.

"$_dailySuggestion"
''';

    print('OZAN_LOG: Translate prompt:\n$prompt');

    try {
      final result = await _gemini.text(prompt);
      print('OZAN_LOG: Translation result: ${result?.output}');
      _setDailySuggestion(result?.output ?? fallBackText);
    } catch (e) {
      print('Gemini error: $e'); // LOG
      _setError(e.toString());
    }
  }



  // Private yardımcı fonksiyonlar
  void _setDailySuggestion(String suggestion) {
    _dailySuggestion = suggestion.trim();
    _isLoading = false;
    notifyListeners();
  }

  void _setImproveProduct(String suggestion) {
    _improveProductResult = suggestion.trim();
    _isLoading = false;
    notifyListeners();
  }

  void _setMarketResearch(String suggestion) {
    _marketResearchResult = suggestion.trim();
    _isLoading = false;
    notifyListeners();
  }


  void _setNewIdeas(String newIdeas) {
    _newIdeasResult = newIdeas.trim();
    _isLoading = false;
    notifyListeners();
  }

  void _setResponse(String response) {
    _response = response;
    _isLoading = false;
    notifyListeners();
  }

  void _setLoading() {
    _isLoading = true;
    _error = '';
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    _response = '';
    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _response = '';
    _error = '';
    _newIdeasResult = '';
    _dailySuggestion = '';
    _improveProductResult = '';
    _marketResearchResult = '';
    _summarizeCommentsResult = '';
    _isLoading = false;
    notifyListeners();
  }
}


