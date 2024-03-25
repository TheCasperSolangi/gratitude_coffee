import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:garttitude_coffee/provider/product_data_provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:garttitude_coffee/orders_screens/activeorders_screen.dart';
import '../homescreen/homescreen.dart';
import '../favourite/favourite_screen.dart';
import '../cart_screen/cart_screen.dart';
import '../settings_screen/settings_screen.dart';

class PastOrdersScreen extends StatefulWidget {
  PastOrdersScreen({Key? key}) : super(key: key);

  @override
  State<PastOrdersScreen> createState() => _PastOrdersScreenState();
}

class _PastOrdersScreenState extends State<PastOrdersScreen> {
  List<Order> pastOrders = [];

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

      String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      String currentUserFirstName = '';

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid)
          .get();

      if (userSnapshot.exists) {
        currentUserFirstName = userSnapshot.get('firstName') ?? '';
      }

      List<Order> fetchedOrders = [];
      for (var order in orders) {
        Order newOrder = Order.fromJson(order['attributes']);

        if (newOrder.firstName == currentUserFirstName &&
            (newOrder.statusName == 'cancelled' || newOrder.statusName == 'completed')) {
          fetchedOrders.add(newOrder);
        }
      }

      setState(() {
        pastOrders = fetchedOrders;
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    child: buildBottomNavItem('Home', 'assets/home.png'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FavouriteScreen()));
                    },
                    child: buildBottomNavItem('Favorite', 'assets/heart.png'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cart_Screen(productData: productData)));
                    },
                    child: buildBottomNavItem('Cart', 'assets/shop.png'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings_Screen()));
                    },
                    child: buildBottomNavItem('My Orders', 'assets/Group 30.png'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings_Screen()));
                    },
                    child: buildBottomNavItem('Settings', 'assets/setting.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 35),
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
                const SizedBox(height: 50),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ActiveOrdersScreen()));
                          },
                          child: Container(
                            height: 54,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            child: Center(
                              child: GradientText(
                                'Active Orders',
                                style: const TextStyle(
                                    fontSize: 17.0, fontWeight: FontWeight.w400),
                                colors: [
                                  const Color(0xff9D9080),
                                  const Color(0xffC3B39E),
                                  const Color(0xff725E45),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 54,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xff9D9080),
                                Color(0xff725E45),
                              ]),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: const Center(
                            child: Text(
                              'Past Orders',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Display past orders here
                Column(
                  children: pastOrders.map((order) {
                    return buildPastOrderCard(order);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomNavItem(String title, String icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          icon,
        ),
        const SizedBox(height: 3),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12.0,
            color: Color(0xffA6A6A6),
          ),
        ),
      ],
    );
  }

  Widget buildPastOrderCard(Order order) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Container(
        width: double.infinity,
        height: 168,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blueGrey.withOpacity(0.2),
        ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Order#${order.orderId}',
                        style: const TextStyle(color: Color(0xffA7A7A7), fontSize: 10),
                      ),
                      const SizedBox(width: 30),
                      Row(
                        children: [
                          const Text(
                            'Status: ',
                            style: TextStyle(fontSize: 10, color: Color(0xff9CA3AF)),
                          ),
                          Text(
                            order.statusName,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff9D9080),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      GradientText(
                        'Product: ',
                        style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
                        colors: [
                          const Color(0xff9D9080),
                          const Color(0xffC3B39E),
                          const Color(0xff725E45),
                        ],
                      ),
                      Text(
                        order.firstName,
                        style: const TextStyle(
                          color: Color(0xff9D9080),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 155,
                    child: Text(
                      order.comment,
                      style: const TextStyle(fontSize: 8, color: Color(0xff9CA3AF)),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Price: ',
                            style: TextStyle(fontSize: 10, color: Color(0xff9CA3AF)),
                          ),
                          Text(
                            '\$${order.orderTotal}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff9D9080),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 63),
                      const Text(
                        'QTY: ',
                        style: TextStyle(fontSize: 10, color: Color(0xff9CA3AF)),
                      ),
                      Text(
                        '${order.totalItems}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff9D9080),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      GradientText(
                        'Estimated Time: ${order.createdAt}',
                        style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
                        colors: [
                          const Color(0xff9D9080),
                          const Color(0xffC3B39E),
                          const Color(0xff725E45),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    order.createdAt,
                    style: const TextStyle(color: Color(0xffA7A7A7), fontSize: 10),
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
    return Order(
      orderId: json['order_id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      telephone: json['telephone'] ?? '',
      totalItems: json['total_items'] ?? 0,
      comment: json['comment'] ?? '',
      payment: json['payment'] ?? '',
      orderType: json['order_type'] ?? '',
      createdAt: json['created_at'] ?? '',
      orderTotal: json['order_total']?.toDouble() ?? 0.0,
      statusName: json['status_name'] ?? '',
    );
  }
}