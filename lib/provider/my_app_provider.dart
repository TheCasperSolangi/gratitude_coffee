import 'package:flutter/material.dart';
import 'package:garttitude_coffee/provider/cart_provider.dart';
import 'package:garttitude_coffee/provider/product_data_provider.dart';

import 'package:garttitude_coffee/main.dart';
import 'package:provider/provider.dart'; // Update the import path to your main.dart

class MyAppProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductDataProvider()..loadProductDataFromPrefs()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    );
  }
}