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

  Future<void> sendPrompt(String prompt) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final result = await _gemini.text(prompt);
      _response = result?.output ?? 'Cevap alınamadı.';
    } catch (e) {
      _error = 'Hata: ${e.toString()}';
      _response = '';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _response = '';
    _error = '';
    _isLoading = false;
    notifyListeners();
  }
}
