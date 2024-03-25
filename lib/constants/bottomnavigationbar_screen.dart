import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:garttitude_coffee/cart_screen/cart_screen.dart';
import 'package:garttitude_coffee/favourite/favourite_screen.dart';
import 'package:garttitude_coffee/orders_screens/activeorders_screen.dart';
import 'package:garttitude_coffee/provider/product_data_provider.dart';
import 'package:garttitude_coffee/settings_screen/settings_screen.dart';
import 'package:provider/provider.dart';

class BottomN extends StatefulWidget {

  
  const BottomN({super.key});

  @override
  State<BottomN> createState() => _BottomNState();
}

class _BottomNState extends State<BottomN> {

        
  @override
  Widget build(BuildContext context) {
      final productData =
        Provider.of<ProductDataProvider>(context).productData;
    return Container(
        height: 77,
        child: BottomAppBar(
          color: Color(0xffF7F7F7),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/bag-2.png',
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xffC3B39E),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavouriteScreen()));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/heart.png',
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      const Text(
                        "Favorite",
                        style:
                            TextStyle(color: Color(0xffA6A6A6), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart_Screen(productData: productData,)));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/shop.png',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Cart",
                        style:
                            TextStyle(color: Color(0xffA6A6A6), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActiveOrdersScreen()));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/bus.png',
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "My Orders",
                        style:
                            TextStyle(color: Color(0xffA6A6A6), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Settings_Screen()));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/setting.png',
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "Settings",
                        style:
                            TextStyle(color: Color(0xffA6A6A6), fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
