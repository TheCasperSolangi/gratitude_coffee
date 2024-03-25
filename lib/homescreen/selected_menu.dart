import 'package:flutter/material.dart';

class SelectedMenuId extends ChangeNotifier {
  late int _menuId;

  int get menuId => _menuId;

  void setMenuId(int id) {
    _menuId = id;
    notifyListeners();
  }
}