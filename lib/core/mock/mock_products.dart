import 'package:ecomarket/core/models/product.dart';

final List<Product> mockProducts = [

  //https://unsplash.com/s/photos/t-shirt-mockup?license=free
  Product(
      starScore: 3.5,
      id: 1,
      name: 'Beyaz Kısa Kollu T-Shirt',
      description: 'Beyaz normal fit kısa kollu t-shirt\n\nS/M/L/XL/XXL',
      price: 500,
      imageUrls: ['assets/products/white_t-shirt/white_t-shirt_1.jpg','assets/products/whiteT-Shirt/white_t-shirt_2.jpg','assets/products/whiteT-Shirt/white_t-shirt_3.jpg'],
      ecoScore: 90,
  ),

  //https://www.pexels.com/tr-tr/@828860/
  Product(
      starScore: 4.7,
      id: 2,
      name: 'Bronzer Pudra',
      description: 'Bronzlaştırıcı pudra 30g',
      price: 600,
      imageUrls: ['assets/products/bronzer_powder/bronzer_1.jpg','assets/products/bronzer/bronzer_2.jpg','assets/products/bronzer/bronzer_3.jpg'],
      ecoScore: 43
  ),

  //https://unsplash.com/@alpha_photographer
  Product(
      starScore: 5,
      id: 3,
      name: 'Beyaz Puma Spor Ayakkabı',
      description: 'Kişiye özel desen seçenekleriyle beyaz orijinal Puma spor ayakkabı. İletişim üzerinden +500tl fark ile desen yapılabilir. \n\n39/40/41/42/43/44/45',
      price: 3000,
      imageUrls: ['assets/products/puma_shoe/puma_shoe_1.jpg','assets/products/puma_shoe/puma_shoe_2.jpg','assets/products/puma_shoe/puma_shoe_3.jpg'],
      ecoScore: 87
  ),

  //https://unsplash.com/@maierfoto
  Product(
      starScore: 4.1,
      id: 4,
      name: 'Kokteyl Bardağı',
      description: 'Tasarım kokteyl bardağı tek boyut',
      price: 300,
      imageUrls: ['assets/products/cocktail_glass/cocktail_glass_1.jpg','assets/products/cocktail_glass/cocktail_glass_2.jpg'],
      ecoScore: 100
  ),

  //https://unsplash.com/@sadswim
  Product(
      starScore: 4.4,
      id: 5,
      name: 'Siyah İskelet Eli Baskılı Kısa Kollu T-Shirt',
      description: 'Siyah iskelet eli baskılı normal fit kısa kollu t-shirt\n\nXS/S/M/L/XL',
      price: 350,
      imageUrls: ['assets/products/skeleton_t-shirt/skeleton_t-shirt_1.jpg','assets/products/skeleton_t-shirt/skeleton_t-shirt_2.jpg','assets/products/skeleton_t-shirt/skeleton_t-shirt_3.jpg',],
      ecoScore: 72
  ),
];