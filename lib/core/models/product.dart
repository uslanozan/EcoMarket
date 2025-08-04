// static classes
class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrls;
  final double ecoScore; // 0-100 arası çevreci puan
  final double starScore;
//todo: Comments eklenecek ve Comment classı yazılacak


  Product({
    required this.starScore,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrls,
    required this.ecoScore,
  });
}
