import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:ecomarket/core/mock/mock_products.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.products),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryGreenLight,
        child: Icon(Icons.add,),
          onPressed: (){
            //todo: yeni ürün ekleme yeri yapılabilir
          }),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: mockProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Bir satırda 2 item
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75, // Kartın boyut oranı
        ),
        itemBuilder: (context, index) {
          final product = mockProducts[index];
          //return Image.asset(mockProducts[index].imageUrls[0]);
          return ProductCard(product: product);
        },
      ),
    );
  }
}
