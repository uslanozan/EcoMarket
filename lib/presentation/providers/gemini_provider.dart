import 'package:ecomarket/core/cache/daily_suggestion_cache.dart';
import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:ecomarket/l10n/app_localizations.dart';

class GeminiProvider extends ChangeNotifier {

  //todo: enum açarak gemini status kontrol etme eklenebilir ama şuan biraz gereksiz
  final Gemini _gemini = Gemini.instance;

  final cache = DailySuggestionCache();

  // prompt results
  // günlük öneri
  String _dailySuggestion= '';
  String get dailySuggestion => _dailySuggestion;

  // yeni fikirler
  String _newIdeas= '';
  String get newIdeas => _newIdeas;

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
    Some of the parameters below may be written in Turkish. Please translate them to English before processing the request, and only use the translated versions in your reasoning. If the 
    parameters are empty or meanless, ignore the parameter.

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


  // Pazar araştırması
  Future<void> doMarketResearch({
    required String productIdea,
    required String targetCountries,
    required String answerLanguage, // Direkt UI tarafından gelecek, Turkish ya da English
    required String fallBackText,
  }) async {
    _setLoading();

    final prompt = '''
Some of the parameters below may be written in Turkish. Please translate them to English before processing the request, and only use the translated versions in your reasoning. 
If the parameters are empty or meaningless, ignore them.

Parameters:
- Product idea: $productIdea
- Target countries/markets: $targetCountries

Do a comprehensive market research on the product idea "$productIdea" for the target region: $targetCountries.

Include details such as:
- Is this product in demand in the target market?
- What types of customers are likely to buy it?
- What is the competitive landscape?
- Are there similar products currently available?
- Through which platforms or marketplaces are they being sold?
- What is the general price range?
- Are there any trends or growth patterns related to this product?
- Any potential risks or limitations?

Make the analysis insightful and actionable for an entrepreneur or product designer. 

Answer in $answerLanguage.
''';

    try {
      final result = await _gemini.text(prompt);
      _setResponse(result?.output ?? fallBackText);
    } catch (e) {
      _setError(e.toString());
    }
  }


  // Ürünü daha çevreci hale getirmek için prompt
  Future<void> improveEcoFriendliness({
    required String productName,
    required String productDescription,
    required String currentMaterials,
    required String targetMarket,
    required String answerLanguage, // Direkt UI tarafından gelecek, Turkish ya da English
    required String fallBackText,
  }) async {
    _setLoading();


    final prompt = '''
Some of the parameters below may be written in Turkish. Please translate them to English before processing the request, and only use the translated versions in your reasoning. If the parameters are empty or meaningless, ignore them.

Parameters:
- Product name: $productName
- Product description: $productDescription
- Current materials: $currentMaterials
- Target market: $targetMarket

Suggest detailed and practical ways to improve the eco-friendliness of the product described above by optimizing materials, production, packaging, or any other factors. Consider sustainability trends relevant to the target market.

Answer in $answerLanguage.
  ''';

    try {
      final result = await _gemini.text(prompt);
      _setResponse(result?.output ?? fallBackText);
    } catch (e) {
      _setError(e.toString());
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
    //todo: BURASI TEST İÇİN SİLİNECEK OTOMATİK REQUEST ATMASIN DİYE ŞUANLIK RETURN BIRAKTIM
    //return;

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

  void _setNewIdeas(String newIdeas) {
    _newIdeas = newIdeas.trim();
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
    _newIdeas = '';
    _dailySuggestion = '';
    _isLoading = false;
    notifyListeners();
  }
}
