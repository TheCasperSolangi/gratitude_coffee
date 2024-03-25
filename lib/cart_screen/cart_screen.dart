import 'package:flutter/material.dart';
import 'package:garttitude_coffee/favourite/favourite_screen.dart';
import 'package:garttitude_coffee/homescreen/homescreen.dart';
import 'package:garttitude_coffee/orders_screens/activeorders_screen.dart';
import 'package:garttitude_coffee/provider/product_data_provider.dart';
import 'package:garttitude_coffee/settings_screen/settings_screen.dart';
import 'package:provider/provider.dart';

class Cart_Screen extends StatefulWidget {
  final Map<String, dynamic> productData;
  const Cart_Screen({super.key, required this.productData});

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
  
}

class _Cart_ScreenState extends State<Cart_Screen> {
  

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Container(
          height: 77,
          child: BottomAppBar(
            color: const Color(0xffF7F7F7),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/home.png',
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color(0xffA6A6A6),
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
                        const SizedBox(
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HistoryScreenOne()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/shopp.png',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Cart",
                          style:
                              TextStyle(color: Color(0xffC3B39E), fontSize: 12),
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
                        const SizedBox(
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
                        const SizedBox(
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
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Cart',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                'assets/cartlogo.png',
              ),
              const SizedBox(
                height: 55,
              ),
              Container(
                  child: const Text(
                'Sorry Cart is empty Right Now goto Products and click on add to Cart',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff9CA3AF),
                    fontWeight: FontWeight.w300),
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
