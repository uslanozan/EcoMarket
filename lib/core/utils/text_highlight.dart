import 'package:flutter/material.dart';

/// Belirli kelimeleri vurgulayan zenginleştirilmiş TextSpan listesi döner.
TextSpan highlightWordsInText({
  required String text,
  required List<String> highlights,
  required TextStyle normalStyle,
  required TextStyle highlightStyle,
}) {
  final spans = <TextSpan>[];
  String remaining = text;

  while (remaining.isNotEmpty) {
    int earliestIndex = remaining.length;
    String? earliestWord;

    for (final word in highlights) {
      final index = remaining.indexOf(word);
      if (index != -1 && index < earliestIndex) {
        earliestIndex = index;
        earliestWord = word;
      }
    }

    if (earliestWord == null) {
      spans.add(TextSpan(text: remaining, style: normalStyle));
      break;
    }

    // Normal kısım
    if (earliestIndex > 0) {
      spans.add(TextSpan(
        text: remaining.substring(0, earliestIndex),
        style: normalStyle,
      ));
    }

    // Vurgulu kelime
    spans.add(TextSpan(
      text: earliestWord,
      style: highlightStyle,
    ));

    // Kalan metin
    remaining = remaining.substring(earliestIndex + earliestWord.length);
  }

  return TextSpan(children: spans);
}
