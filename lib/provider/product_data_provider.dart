import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDataProvider extends ChangeNotifier {
  late Map<String, dynamic> _productData = {};

  Map<String, dynamic> get productData => _productData;

  void setProductData(Map<String, dynamic> data) {
    _productData = data;
    notifyListeners();
    _saveProductDataToPrefs(data);
  }

  Future<void> _saveProductDataToPrefs(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('product_data', json.encode(data));
  }

  Future<void> loadProductDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? productDataString = prefs.getString('product_data');
    if (productDataString != null) {
      _productData = json.decode(productDataString);
      notifyListeners();
    }
  }
}
