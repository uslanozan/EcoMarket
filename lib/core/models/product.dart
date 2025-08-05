// static classes
import 'package:ecomarket/core/models/comment.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrls;
  final double ecoScore; // 0-100 arası çevreci puan
  final double starScore;
  final List<Comment> comments;


  Product({
    required this.starScore,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrls,
    required this.ecoScore,
    this.comments =  const [], // default boş geliyor
  });

  //değiştirilmiş özellikli yeni kopyalar oluşturulur
  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    List<String>? imageUrls,
    double? ecoScore,
    double? starScore,
    List<Comment>? comments,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrls: imageUrls ?? this.imageUrls,
      ecoScore: ecoScore ?? this.ecoScore,
      starScore: starScore ?? this.starScore,
      comments: comments ?? this.comments,
    );
  }
}
