// static classes
import 'package:ecomarket/core/models/user.dart';

class Seller extends User {
  final bool isOnline; // gerek yok kaldırılabilir
  final int differentProductCount;
  final List<String> targetCountries;
  final String location;

  Seller({
    required super.id,
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

  Seller copyWith({
    int? id,
    String? name,
    String? surName,
    String? email,
    String? phone,
    bool? isOnline,
    int? differentProductCount,
    List<String>? targetCountries,
    String? location,
    String? avatarUrl,
  }) {
    return Seller(
      id: id ?? this.id,
      name: name ?? this.name,
      surName: surName ?? this.surName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isOnline: isOnline ?? this.isOnline,
      differentProductCount: differentProductCount ?? this.differentProductCount,
      targetCountries: targetCountries ?? this.targetCountries,
      location: location ?? this.location,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
