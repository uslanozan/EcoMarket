import 'package:shared_preferences/shared_preferences.dart';

class DailySuggestionCache {
  static const String suggestionKeyPrefix = 'daily_suggestion_';  // Örn: daily_suggestion_English, daily_suggestion_Turkish
  static const String dateKeyPrefix = 'suggestion_date_';        // Örn: suggestion_date_English, suggestion_date_Turkish

  Future<String?> getCachedSuggestion(String language) async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString('$dateKeyPrefix$language');
    final today = DateTime.now().toIso8601String().substring(0, 10); // YYYY-MM-DD formatında

    if (savedDate == today) {
      return prefs.getString('$suggestionKeyPrefix$language');
    } else {
      return null; // Cache yok veya tarih güncel değil
    }
  }

  Future<void> saveSuggestion(String language, String suggestion) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    await prefs.setString('$suggestionKeyPrefix$language', suggestion.trim());
    await prefs.setString('$dateKeyPrefix$language', today);
  }
}
