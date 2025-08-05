import 'package:ecomarket/config/theme/app_theme.dart';
import 'package:ecomarket/core/models/product.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();

  final Product product;

}

class _ProductCardState extends State<ProductCard> {


  void _showProductDetails(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        title: Text(
          product.name,
          style: TextTheme.of(context)
              .titleLarge
              ?.copyWith(color: AppTheme.primaryGreenLight),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 300,
                  child: PageView.builder(
                    itemCount: product.imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.asset(product.imageUrls[index],
                          fit: BoxFit.cover);
                    },
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  product.description,
                  textAlign: TextAlign.start,
                  style: TextTheme.of(context).bodyLarge,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      '${product.price.toString().replaceAll('.', ',')} TL',
                      textAlign: TextAlign.start,
                      style: TextTheme.of(context).bodyLarge,
                    ),
                    IconButton(
                      onPressed: () {
                        _editPrice(context, widget.product.price); //todo: BURADAKİ DE DEĞİŞECEK
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppTheme.primaryGreenLight,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          '${widget.product.starScore}/5',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/leaf.png',
                          height: 15,
                          width: 15,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          '${widget.product.ecoScore}/100',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 400,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: product.comments.length,
                      itemBuilder: (context, index) {
                        final comment = product.comments[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${comment.customer.name} ${comment.customer.surName}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '⭐ ${comment.star} / 5',
                                  style: const TextStyle(color: Colors.orange),
                                ),
                                const SizedBox(height: 8),
                                Text(comment.commentText),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.close),
          ),
        ],
      ),
    );
  }


  void _editPrice(BuildContext context, double oldPrice) {
    final TextEditingController _priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        title: Text(
          AppLocalizations.of(context)!.newPrice,
          style: TextTheme.of(context)
              .titleLarge
              ?.copyWith(color: AppTheme.primaryGreenLight),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.noSave),
          ),

          TextButton(
            onPressed: (){
              double? newPrice = double.tryParse(_priceController.text.replaceAll(',', '.'));
              if (newPrice != null) {
                context.read<ProductProvider>().updateProductPrice(
                  widget.product.id,
                  newPrice,
                );
              }
              //todo: Burada provider'daki update fonksiyonunu kullanmak istiyorum
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // En altta Consumer<ProductProvider> ile sarmaladık bu yüzden daha üstlerde
    // updatedProduct'u parametre olarak gönderince bir değişiklik her yerde etkili olabiliyor
    return Consumer<ProductProvider>(
      builder: (context,provider,_){
        final updatedProduct = provider.products.firstWhere((p) => p.id == widget.product.id);
        return GestureDetector(
            onTap: () {
              _showProductDetails(context, updatedProduct);
            },
            //todo: Consumer<ProductProvider> ile sarmalamak gerekli
            child: Card(
              elevation: 4.0,
              margin: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Product Image
                  Expanded(
                    // container kullansak bile içindeki child onun decoration
                    // sınırlarına uymak zorunda değil. O yüzden ClipRRect
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: Image.asset(
                        widget.product.imageUrls.isNotEmpty
                            ? widget.product.imageUrls.first
                            : 'https://via.placeholder.com/150', // Placeholder image
                        fit: BoxFit.cover,
                      ),
                    )
                  ),

                  // Product Details
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Product Name
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4.0),

                        // Star and Eco Score
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Star Score
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16.0,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  '${widget.product.starScore}',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),

                            // Eco Score
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/leaf.png',
                                  height: 15,
                                  width: 15,
                                ),
                                /*
                          const Icon(
                            Icons.eco,
                            color: Colors.green,
                            size: 16.0,
                          ),

                           */
                                const SizedBox(width: 4.0),
                                Text(
                                  '${widget.product.ecoScore}',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),

                        // Product Price
                        Text(
                          '${updatedProduct.price.toStringAsFixed(2).replaceAll('.', ',')} TL',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryGreenLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}
