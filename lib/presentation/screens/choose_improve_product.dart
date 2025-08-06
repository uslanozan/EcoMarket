import 'package:ecomarket/core/globals/globals.dart';
import 'package:ecomarket/core/mock/mock_products.dart';
import 'package:ecomarket/core/models/product.dart';
import 'package:ecomarket/l10n/app_localizations.dart';
import 'package:ecomarket/presentation/screens/improve_product_result.dart';
import 'package:ecomarket/presentation/screens/summarize_feedback_result_screen.dart';
import 'package:ecomarket/presentation/widgets/doodle_background.dart';
import 'package:flutter/material.dart';

class ChooseImproveProduct extends StatefulWidget {
  const ChooseImproveProduct({super.key});

  @override
  State<ChooseImproveProduct> createState() => _ChooseImproveProductState();
}

class _ChooseImproveProductState extends State<ChooseImproveProduct> {
  Product? _selectedProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DoodleBackground(
              child: Container(
                height: 600,
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: mockProducts.length,
                        itemBuilder: (context, index) {
                          final product = mockProducts[index];
                          final isSelected = _selectedProduct?.id == product.id;

                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            elevation: isSelected ? 4 : 2,
                            color: isSelected
                                ? Theme.of(context).primaryColor.withOpacity(0.1)
                                : Theme.of(context).cardColor,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  product.imageUrls.first,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                product.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              subtitle: Text(
                                '${AppLocalizations.of(context)!.price}: ${product.price.toString().replaceAll('.', ',')} TL',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              trailing: isSelected
                                  ? const Icon(Icons.check_circle, color: Colors.green)
                                  : null,
                              onTap: () {
                                setState(() {
                                  _selectedProduct = product;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: _selectedProduct == null
                            ? null
                            : () {
                          global_ecoImproveAnswers['name'] = _selectedProduct!.name.toString();
                          global_ecoImproveAnswers['description'] = _selectedProduct!.description.toString();
                          // buralar textformfield'dan gelecek
                          //global_ecoImproveAnswers['material'] = _selectedProduct!..toString();
                          //global_ecoImproveAnswers['targetCountry'] = _selectedProduct!.t.toString();


                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImproveProductResult(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(AppLocalizations.of(context)!.seeTheImprovedProduct),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
