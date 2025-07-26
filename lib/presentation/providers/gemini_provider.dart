import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiProvider extends ChangeNotifier {
  final Gemini _gemini = Gemini.instance;

  String _response = '';
  bool _isLoading = false;
  String _error = '';

  String get response => _response;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Genel prompt gönderme fonksiyonu (isteğe bağlı)
  Future<void> sendPrompt(String prompt) async {
    _setLoading();
    try {
      final result = await _gemini.text(prompt);
      _setResponse(result?.output ?? 'Cevap alınamadı.');
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Yeni ürün fikirleri için prompt
  Future<void> generateNewProductIdeas({
    required String productCategory,
    required String material,
    required String targetCountry,
    required String ecoFriendly,
    required String budget,
    required String answerLanguage, // Direkt UI tarafından gelecek, Turkish ya da English
  }) async {
    _setLoading();


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

    try {
      final result = await _gemini.text(prompt);
      _setResponse(result?.output ?? 'Cevap alınamadı.');
    } catch (e) {
      _setError(e.toString());
    }
  }


  // Pazar araştırması
  Future<void> doMarketResearch({
    required String productIdea,
    required String targetCountries,
    required String answerLanguage, // Direkt UI tarafından gelecek, Turkish ya da English
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
      _setResponse(result?.output ?? 'Cevap alınamadı.');
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
      _setResponse(result?.output ?? 'Cevap alınamadı.');
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Ürünün kullanıcı yorumlarını analiz eder ve özetler
  Future<void> summarizeUserFeedback({
    required String productName,
    required String userFeedbacks,  // Kullanıcı geri dönüşleri, uzun metin olarak veya birleştirilmiş hali
    required String answerLanguage, // Direkt UI tarafından gelecek, Turkish ya da English
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
      _setResponse(result?.output ?? 'Cevap alınamadı.');
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Günlük öneri kısmı
  Future<void> getDailySuggestion({
    required String answerLanguage
  }) async {
    _setLoading();

    final prompt = '''
Provide a fresh and innovative daily suggestion related to e-commerce, lifestyle, or sustainability. 
The suggestion should be inspiring and useful, but it does not require any input parameters.
Answer in $answerLanguage.
''';

    try {
      final result = await _gemini.text(prompt);
      _setResponse(result?.output ?? 'No suggestion available.');
    } catch (e) {
      _setError(e.toString());
    }
  }




  // Private yardımcı fonksiyonlar
  void _setLoading() {
    _isLoading = true;
    _error = '';
    notifyListeners();
  }

  void _setResponse(String response) {
    _response = response;
    _isLoading = false;
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
    _isLoading = false;
    notifyListeners();
  }
}
