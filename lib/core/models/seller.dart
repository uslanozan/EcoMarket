// static classes
import 'package:ecomarket/core/models/user.dart';

class Seller extends User {
  final bool isOnline; // gerek yok kaldırılabilir
  final int differentProductCount;
  final List<String> targetCountries;
  final String location;

  Seller(
      {required super.id,
      required super.name,
      required super.surName,
      required super.email,
      required super.phone,
      required this.isOnline,
      required this.differentProductCount,
      required this.targetCountries,
      required this.location,
      required super.avatarUrl,

      });
}
