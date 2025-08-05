import 'package:ecomarket/core/models/customer.dart';
import 'package:ecomarket/core/mock/mock_products.dart'; // mockProducts için
import 'package:ecomarket/core/models/product.dart';

final List<Customer> mockCustomers = [
  Customer(
    id: 1,
    name: 'Mustafa',
    surName: 'Kemal',
    email: 'mustafa.kemal@example.com',
    phone: '+90 532 111 2233',
    avatarUrl: 'assets/avatars/user_man.png',
    addressList: ['Ankara, Çankaya, Atatürk Bulvarı, No:1'],
    location: 'Ankara, Türkiye',
  ),
  Customer(
    id: 2,
    name: 'Sabiha',
    surName: 'Gökçen',
    email: 'sabiha.gokcen@example.com',
    phone: '+90 530 444 5566',
    avatarUrl: 'assets/avatars/user_woman.png',
    addressList: ['İstanbul, Kadıköy, Bağdat Caddesi, No:2'],
    location: 'İstanbul, Türkiye',
  ),
  Customer(
    id: 3,
    name: 'Elif',
    surName: 'Demir',
    email: 'elif.demir@example.com',
    phone: '+90 533 222 3344',
    avatarUrl: 'assets/avatars/user_woman.png',
    addressList: ['İzmir, Konak, Cumhuriyet Meydanı, No:3'],
    location: 'İzmir, Türkiye',
  ),
  Customer(
    id: 4,
    name: 'Ahmet',
    surName: 'Şahin',
    email: 'ahmet.sahin@example.com',
    phone: '+90 552 666 7788',
    avatarUrl: 'assets/avatars/user_man.png',
    addressList: ['Bursa, Osmangazi, Heykel, No:4'],
    location: 'Bursa, Türkiye',
  ),
  Customer(
    id: 5,
    name: 'Merve',
    surName: 'Kara',
    email: 'merve.kara@example.com',
    phone: '+90 531 999 0011',
    avatarUrl: 'assets/avatars/user_woman.png',
    addressList: ['Adana, Seyhan, Atatürk Parkı, No:5'],
    location: 'Adana, Türkiye',
  ),
];