import 'package:flutter/material.dart';
import 'package:ecomarket/core/models/product.dart';
import 'package:ecomarket/core/mock/mock_products.dart';

class ProductProvider extends ChangeNotifier {

  List<Product> _products = [...mockProducts]; // mock veriyi klonla
  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  void updateProductPrice(int productId, double newPrice) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _products[index] = _products[index].copyWith(price: newPrice);
      notifyListeners();
    }
  }

  void editProduct(Product updatedProduct) {
    final index = _products.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
      notifyListeners(); // UI’yı güncelle
    }
  }


  //todo: İLERİDE Back-End ile bağlanınca fonksiyonlar değişecek
}
