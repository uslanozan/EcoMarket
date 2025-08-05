import 'package:ecomarket/core/models/customer.dart';
import 'package:ecomarket/core/mock/mock_products.dart'; // mockProducts için
import 'package:ecomarket/core/models/product.dart';

final List<Customer> mockCustomers = [
  Customer(
    id: 1,
    name: 'Zeynep',
    surName: 'Yılmaz',
    email: 'zeynep.yilmaz@example.com',
    phone: '+90 532 111 2233',
    avatarUrl: 'assets/avatars/user_woman.png',
  ),
  Customer(
    id: 2,
    name: 'Ali',
    surName: 'Koç',
    email: 'ali.koc@example.com',
    phone: '+90 530 444 5566',
    avatarUrl: 'assets/avatars/user_man.png',
  ),
  Customer(
    id: 3,
    name: 'Elif',
    surName: 'Demir',
    email: 'elif.demir@example.com',
    phone: '+90 533 222 3344',
    avatarUrl: 'assets/avatars/user_woman.png',
  ),
  Customer(
    id: 4,
    name: 'Ahmet',
    surName: 'Şahin',
    email: 'ahmet.sahin@example.com',
    phone: '+90 552 666 7788',
    avatarUrl: 'assets/avatars/user_man.png',
  ),
  Customer(
    id: 5,
    name: 'Merve',
    surName: 'Kara',
    email: 'merve.kara@example.com',
    phone: '+90 531 999 0011',
    avatarUrl: 'assets/avatars/user_woman.png',
  ),
];
