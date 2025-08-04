import 'package:ecomarket/core/models/customer.dart';
import 'package:ecomarket/core/models/product.dart';

// static classes
enum ProcessStatus { pending, shipped, delivered, cancelled }

class ProductProcess {
  final int id;
  final Customer customer;
  final Product product;
  final DateTime date;
  final ProcessStatus status;
  final int quantity;

  ProductProcess({
    required this.quantity,
    required this.id,
    required this.customer,
    required this.product,
    required this.date,
    required this.status,
  });
}
