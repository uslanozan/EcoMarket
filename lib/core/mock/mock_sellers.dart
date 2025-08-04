import 'package:ecomarket/core/models/seller.dart';

final List<Seller> mockSellers = [
  Seller(
      id: 48,
      isOnline: true,
      differentProductCount: 5, // 5 farklı ürün çeşidi
      targetCountries: ['Türkiye', 'KKTC','İtalya'],
      location: 'Muğla, Türkiye',
      name: 'Ozan',
      surName: 'Uslan',
      email: 'uslanozan@gmail.com',
      avatarUrl: 'assets/avatars/ozan_avatar.jpg',
      phone: '+90 555 555 55 55',
  ),

  Seller(
      id: 35,
      isOnline: false,
      differentProductCount: 2,
      targetCountries: ['Türkiye'],
      location: 'Ankara, Muğla',
      name: 'Ahmet',
      surName: 'Taş',
      email: 'ahmet.tas@example.com',
      avatarUrl: 'assets/avatars/user_man.png',
      phone: '+90 544 444 44 44',
  ),


];