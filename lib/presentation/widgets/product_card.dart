import 'package:ecomarket/core/models/product.dart';
import 'package:flutter/material.dart';

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
  // It's better to make it a StatelessWidget if the state doesn't change internally.
  // The product data is passed in as a final variable.



  @override
  Widget build(BuildContext context) {
    return Card(
      //todo: onTap yapmak gerekli
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Product Image
          Expanded(
            child: Image.asset(
              widget.product.imageUrls.isNotEmpty
                  ? widget.product.imageUrls.first
                  : 'https://via.placeholder.com/150', // Placeholder image
              fit: BoxFit.cover,
            ),
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
                        const Icon(
                          Icons.eco,
                          color: Colors.green,
                          size: 16.0,
                        ),
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
                  '${widget.product.price.toStringAsFixed(2)} TL',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
