class Answer {
  final String productCategory;
  final String material;
  final String targetCountry;
  final String ecoFriendly; // Evet - Hayır - Fark Etmez
  final String budget; // Düşük - Orta - Yüksek

  const Answer({
    required this.productCategory,
    required this.material,
    required this.targetCountry,
    required this.ecoFriendly,
    required this.budget,
  });
}
