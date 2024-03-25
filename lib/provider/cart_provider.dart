import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String product;
  final String description;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.description,
    required this.price,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  void addItem(String id, String product, String description, double price) {
    final existingIndex = _items.indexWhere((item) => item.id == id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += 1;
    } else {
      _items.add(CartItem(
        id: id,
        product: product,
        description: description,
        price: price,
      ));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void clearCart() {
    _items = [];
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0;
    _items.forEach((item) {
      total += item.price * item.quantity;
    });
    return total;
  }
}