import 'package:flutter/material.dart';
import 'package:ecomarket/core/globals/globals.dart' as global;

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;

    // 🌍 Global değişkeni burada güncelle
    global.global_language = locale.languageCode == 'tr' ? 'Turkish' : 'English';

    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('en');
    global.global_language = 'English'; // temizlerken de set et
    notifyListeners();
  }
}
