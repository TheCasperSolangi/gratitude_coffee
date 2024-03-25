import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../cart_screen/cart_screen.dart';
import '../favourite/favourite_screen.dart';
import '../orders_screens/pastorders_screen.dart';
import '../provider/product_data_provider.dart';
import '../settings_screen/settings_screen.dart';
import '../homescreen/homescreen.dart';
import '../constants/listsdata.dart'; // Assuming you have your constants defined here.

class ActiveOrdersScreen extends StatefulWidget {
  ActiveOrdersScreen({Key? key}) : super(key: key);

  @override
  State<ActiveOrdersScreen> createState() => _ActiveOrdersScreenState();
}

class _ActiveOrdersScreenState extends State<ActiveOrdersScreen> {
  List<Order> activeOrders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }


Future<void> fetchOrders() async {
  try {
    var url = Uri.parse('http://157.245.111.134/tastyig/api/orders');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 1|P9HlpDjQuKe9fWHrdKX5ZqpyP8imB0WCpAIA1dbAn4gitW67fH38O9TUR5eK4akEW4GUevmlBw3Fzsv5'
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var orders = data['data'];

      // Fetch current user's first name from Firestore
      String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      String currentUserFirstName = '';

      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(currentUserUid).get();

      if (userSnapshot.exists) {
        currentUserFirstName = userSnapshot.get('firstName') ?? '';
      }

      List<Order> fetchedOrders = [];
      for (var order in orders) {
        Order newOrder = Order.fromJson(order);

        // Filter orders based on customer name (firstName in this case)
        if (newOrder.firstName == currentUserFirstName) {
          fetchedOrders.add(newOrder);
        }
      }

      setState(() {
        activeOrders = fetchedOrders;
      });
    } else {
      print('Failed to fetch orders: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching orders: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductDataProvider>(context).productData;
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset('assets/home.png'),
                        const SizedBox(height: 3),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset('assets/heart.png'),
                        const SizedBox(height: 3),
                        const Text(
                          "Favorite",
                          style: TextStyle(color: Color(0xffA6A6A6), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Cart_Screen(productData: productData)));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset('assets/shop.png'),
                        const SizedBox(height: 5),
                        const Text(
                          "Cart",
                          style: TextStyle(color: Color(0xffA6A6A6), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset('assets/Group 30.png'),
                        const SizedBox(height: 5),
                        const Text(
                          "My Orders",
                          style: TextStyle(color: Color(0xffC3B39E), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Settings_Screen()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset('assets/setting.png'),
                        const SizedBox(height: 4),
                        const Text(
                          "Settings",
                          style: TextStyle(color: Color(0xffA6A6A6), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 35),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'My Orders',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 54,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [Color(0xff9D9080), Color(0xff725E45)]),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                          ),
                          child: const Center(
                            child: Text(
                              'Active Orders',
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PastOrdersScreen()));
                          },
                          child: Container(
                            height: 54,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                            ),
                            child: Center(
                              child: GradientText(
                                'Past Orders',
                                style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                                colors: [const Color(0xff9D9080), const Color(0xffC3B39E), const Color(0xff725E45)],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ...activeOrders.map((order) => buildOrderCard(order)).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOrderCard(dynamic order) {
    if (order == null) {
      // Handle the case where the order is null
      return SizedBox(); // Or any other widget you want to show
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Container(
        width: double.infinity,
        height: 163,
        child: Row(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/Background.png',
                  fit: BoxFit.fill,
                  width: 150,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Order#${order.orderId}', // Accessing order properties directly
                        style: TextStyle(color: Color(0xffA7A7A7), fontSize: 10),
                      ),
                      const SizedBox(width: 37),
                      Row(
                        children: [
                          const Text(
                            'Status: ',
                            style: TextStyle(fontSize: 10, color: Color(0xff9CA3AF)),
                          ),
                          Text(
                            order.statusName, // Accessing order properties directly
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xff9D9080)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      GradientText(
                        'Product: ',
                        style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
                        colors: [const Color(0xff9D9080), const Color(0xffC3B39E), const Color(0xff725E45)],
                      ),
                      Text(
                        order.firstName, // Accessing order properties directly
                        style: TextStyle(color: Color(0xff9D9080), fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 155,
                    child: Text(
                      order.comment, // Accessing order properties directly
                      style: TextStyle(fontSize: 8, color: Color(0xff9CA3AF)),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Price: ',
                            style: TextStyle(fontSize: 10, color: Color(0xff9CA3AF)),
                          ),
                          Text(
                            '\$${order.orderTotal}', // Accessing order properties directly
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xff9D9080)),
                          ),
                        ],
                      ),
                      const SizedBox(width: 60),
                      const Text(
                        'QTY: ',
                        style: TextStyle(fontSize: 10, color: Color(0xff9CA3AF)),
                      ),
                      Text(
                        order.totalItems.toString(), // Accessing order properties directly
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xff9D9080)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      GradientText(
                        'Time Left:',
                        style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
                        colors: [const Color(0xff9D9080), const Color(0xffC3B39E), const Color(0xff725E45)],
                      ),
                      const SizedBox(width: 70),
                      const Text(
                        '3 min',
                        style: TextStyle(color: Color(0xffA7A7A7), fontSize: 10),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Order {
  final int orderId;
  final String firstName;
  final String lastName;
  final String email;
  final String telephone;
  final int totalItems;
  final String comment;
  final String payment;
  final String orderType;
  final String createdAt;
  final double orderTotal;
  final String statusName;

  Order({
    required this.orderId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.telephone,
    required this.totalItems,
    required this.comment,
    required this.payment,
    required this.orderType,
    required this.createdAt,
    required this.orderTotal,
    required this.statusName,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];

    return Order(
      orderId: attributes['order_id'] ?? 0,
      firstName: attributes['first_name'] ?? '',
      lastName: attributes['last_name'] ?? '',
      email: attributes['email'] ?? '',
      telephone: attributes['telephone'] ?? '',
      totalItems: attributes['total_items'] ?? 0,
      comment: attributes['comment'] ?? '',
      payment: attributes['payment'] ?? '',
      orderType: attributes['order_type'] ?? '',
      createdAt: attributes['created_at'] ?? '',
      orderTotal: attributes['order_total']?.toDouble() ?? 0.0,
      statusName: attributes['status_name'] ?? '',
    );
  }
}
