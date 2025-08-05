import 'package:ecomarket/core/models/customer.dart';
import 'package:ecomarket/core/models/product.dart';

class Comment {
  final String commentText;
  final double star;
  final Customer customer; // Evet - Hayır - Fark Etmez

  const Comment({
    required this.commentText,
    required this.star,
    required this.customer,
  });

}