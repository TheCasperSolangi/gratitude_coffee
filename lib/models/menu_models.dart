import 'package:flutter/material.dart';
class Menu {
  int menuId;
  String menuName;
  String menuDescription;
  double menuPrice;
  int minimumQty;
  bool isFavorite; // assuming this is the field for favorite status

  Menu({
    required this.menuId,
    required this.menuName,
    required this.menuDescription,
    required this.menuPrice,
    required this.minimumQty,
    this.isFavorite = false, // setting a default value
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menuId: json['menu_id'],
      menuName: json['menu_name'],
      menuDescription: json['menu_description'],
      menuPrice: json['menu_price'].toDouble(),
      minimumQty: json['minimum_qty'],
      isFavorite: json['is_favorite'] ?? false, // assigning a default value if null
    );
  }
}