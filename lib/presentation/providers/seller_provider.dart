import 'package:ecomarket/core/mock/mock_datas.dart';
import 'package:ecomarket/core/models/seller.dart';
import 'package:flutter/material.dart';

class SellerProvider extends ChangeNotifier {

  List<Seller> _sellers = [...mockSellers]; // mock veriyi klonla
  List<Seller> get sellers => _sellers;



  void editProfile({required Seller newSellerData}) {
    final int index = _sellers.indexWhere((seller) => seller.id == newSellerData.id);

    if (index != -1) {
      // Create a new list with the updated seller
      _sellers[index] = newSellerData;
      // Notify listeners that the data has changed
      notifyListeners();
    }
  }



//todo: İLERİDE Back-End ile bağlanınca fonksiyonlar değişecek
}
