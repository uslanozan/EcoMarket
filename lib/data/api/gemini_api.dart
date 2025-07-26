import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiApiService {
  final Gemini _gemini = Gemini.instance;

  /// Bu init'i main.dart içinde bir kere çağırmalısın
  static void initialize() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY not found in .env');
    }
    //print("GEMINI_API_KEY: ${apiKey}");
    Gemini.init(apiKey: apiKey);
  }

  Future<String> generateSuggestion(String prompt) async {
    try {
      final response = await _gemini.text(prompt);
      return response?.output ?? "Hiçbir öneri bulunamadı.";
    } catch (e) {
      return "Bir hata oluştu: $e";
    }
  }
}
