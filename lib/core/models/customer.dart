// static classes
import 'package:ecomarket/core/models/product.dart';
import 'package:ecomarket/core/models/user.dart';

class Customer extends User {

  Customer(
      {required super.id,
      required super.name,
      required super.email,
      required super.avatarUrl,
      required super.phone,
      required super.surName});
}
