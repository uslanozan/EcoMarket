import 'package:flutter_test/flutter_test.dart';
import 'package:ecomarket/core/utils/parser.dart'; // parseSections fonksiyonun burada

//todo: Unit test denemesi, düzgün yazılacak
void main() {
  group('parseSections', () {
    test('Bölümleri doğru şekilde ayırıyor ve hasList değerini tespit ediyor', () {
      final input = '''
+Market Demand+

This product is highly demanded in the market.

+Target Customer Segments+

++Young adults++: They prefer modern style.
++Professionals++: They seek durability.

+Competitive Landscape+

Market is quite saturated.
''';

      final result = parseSections(input);

      expect(result.containsKey('Market Demand'), true);
      expect(result.containsKey('Target Customer Segments'), true);
      expect(result.containsKey('Competitive Landscape'), true);

      expect(result['Market Demand']!['hasList'], false);
      expect(result['Target Customer Segments']!['hasList'], true);
      expect(result['Competitive Landscape']!['hasList'], false);

      expect(result['Market Demand']!['content'], contains('highly demanded'));
      expect(result['Target Customer Segments']!['content'], contains('++Young adults++'));
      expect(result['Competitive Landscape']!['content'], contains('saturated'));
    });
  });
}
