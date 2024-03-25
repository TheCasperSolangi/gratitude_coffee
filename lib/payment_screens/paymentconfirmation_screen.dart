import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garttitude_coffee/payment_screens/order_id_controller.dart';
import 'package:garttitude_coffee/provider/cart_provider.dart';
import 'package:garttitude_coffee/provider/getx_menuid.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../constants/mainbutton.dart';
import 'paymentmethod_screen.dart';
import 'successfullpaid_screen.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  const PaymentConfirmationScreen({Key? key});

  @override
  State<PaymentConfirmationScreen> createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  int _menuId = 0;
  String _menuName = '';
  String _menuDescription = '';
  double _menuPrice = 0.0;
  int _minimumQty = 0;
  bool? _menuStatus;
  int _menuPriority = 0;
  String _createdAt = '';
  String _updatedAt = '';
  int _stockQty = 0;
  List<dynamic> _stocks = [];
  String _currency = '';
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;

  late User _user;

  void fetchMenuDetails(int menuId) async {
    final url = Uri.parse('http://157.245.111.134/tastyig/api/menus/$menuId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        final Map<String, dynamic> data = jsonResponse['data'];
        final Map<String, dynamic> attributes = data['attributes'];

        setState(() {
          _menuId = attributes['menu_id'];
          _menuName = attributes['menu_name'];
          _menuDescription = attributes['menu_description'];
          _menuPrice = attributes['menu_price'].toDouble();
          _minimumQty = attributes['minimum_qty'];
          _menuStatus = attributes['menu_status'];
          _menuPriority = attributes['menu_priority'];
          _createdAt = attributes['created_at'];
          _updatedAt = attributes['updated_at'];
          _stockQty = attributes['stock_qty'];
          _stocks = attributes['stocks'];
          _currency = attributes['currency'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during API call: $e');
    }
  }

  Future<void> fetchData() async {
    try {
      // Get current user's UID
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Access a specific collection using the user's UID
      DocumentReference docRef = firestore.collection('users').doc(uid);

      // Get the document snapshot
      DocumentSnapshot docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // Extract firstName and lastName
        setState(() {
          firstName = docSnapshot.get('firstName') ?? '';
          lastName = docSnapshot.get('lastName') ?? '';
          email = docSnapshot.get('email') ?? '';
          phoneNumber = docSnapshot.get('phoneNumber') ?? '';
        });

        // Print the retrieved data along with the UID
        print('UID: $uid');
        print('First Name: $firstName');
        print('Last Name: $lastName');
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error as needed
    }
  }

  void placeOrder(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    await fetchData();

    final orderController =
        Get.put(OrderController()); // Initialize OrderController

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 1|P9HlpDjQuKe9fWHrdKX5ZqpyP8imB0WCpAIA1dbAn4gitW67fH38O9TUR5eK4akEW4GUevmlBw3Fzsv5'
    };

    var orderMenu = {
      "rowId": 0,
      "id": _menuId,
      "name": _menuName,
      "qty": 1, // You can set the quantity as needed
      "price": _menuPrice.toStringAsFixed(4),
      "subtotal": (_menuPrice * 1).toStringAsFixed(4),
      "comment": generateRandomComment(), // Generate a random comment
      "options": []
    };

    var request = http.Request(
        'POST', Uri.parse('http://157.245.111.134/tastyig/api/orders'));
    request.headers.addAll(headers);

    var now = DateTime.now();
    var dateFormat = DateFormat('yyyy-MM-dd');
    var timeFormat = DateFormat('HH:mm');

    var randomDocId =
        FirebaseFirestore.instance.collection('active_order').doc().id;

    request.body = jsonEncode({
      "location_id": 1,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "telephone": phoneNumber,
      "comment": "Give me my food",
      "order_type": "collection",
      "order_date": dateFormat.format(now),
      "order_time": timeFormat.format(now),
      "payment": "cod",
      "processed": 1,
      "status_id": 1,
      "status_comment": "My comment",
      "order_menus": [orderMenu],
      "order_totals": [
        {
          "code": "total",
          "title": "Total",
          "value": cartProvider.getTotalPrice(), // Using cart total price
          "priority": 1
        }
      ],
      "order_total": cartProvider.getTotalPrice(), // Using cart total price
      "random_doc_id": randomDocId,
      "user_id":
          FirebaseAuth.instance.currentUser!.uid // User ID for identification
    });

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Placing Order"),
            content: const Text("Please wait..."),
          );
        },
      );

      await Future.delayed(Duration(seconds: 2 + Random().nextInt(5)));

      http.StreamedResponse response = await request.send();
      String responseString = await response.stream.bytesToString();
      print("Order Response: $responseString");

      if (response.statusCode == 200) {
        String orderId = getOrderIdFromResponse(
            responseString); // Get the order ID from the response

        print("Order Response: $orderId");

        orderController
            .setOrderId(orderId); // Save the order ID using GetX controller

        FirebaseFirestore.instance
            .collection('active_order')
            .doc(randomDocId)
            .set({
          "order_details": {
            "location_id": 1,
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "telephone": phoneNumber,
            "comment": "Give me my food",
            "order_type": "collection",
            "order_date": dateFormat.format(now),
            "order_time": timeFormat.format(now),
            "payment": "cod",
            "processed": 1,
            "status_id": 1,
            "status_comment": "My comment",
            "order_menus": [orderMenu],
            "order_totals": [
              {
                "code": "total",
                "title": "Total",
                "value": cartProvider.getTotalPrice(), // Using cart total price
                "priority": 1
              }
            ],
            "order_total":
                cartProvider.getTotalPrice(), // Using cart total price
            "user_id": FirebaseAuth
                .instance.currentUser!.uid // User ID for identification
          },
          "timestamp": FieldValue.serverTimestamp(),
        });

        Future.delayed(Duration(minutes: 30), () {
          FirebaseFirestore.instance
              .collection('active_order')
              .doc(randomDocId)
              .get()
              .then((snapshot) {
            if (snapshot.exists) {
              FirebaseFirestore.instance
                  .collection('past_orders')
                  .doc(snapshot.id)
                  .set(snapshot.data() ?? {});
              FirebaseFirestore.instance
                  .collection('active_order')
                  .doc(snapshot.id)
                  .delete();
            }
          });
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SuccessfullPaidScreen(),
          ),
        );
      } else {
        print(response.reasonPhrase);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error Placing Order"),
              content: Text(
                  "There was an error placing your order. Please try again."),
            );
          },
        );
      }
    } catch (e) {
      print('Exception during order placement: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error Placing Order"),
            content: Text(
                "There was an error placing your order. Please try again."),
          );
        },
      );
    } finally {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SuccessfullPaidScreen(),
        ),
      );
    }
  }

// Function to generate a random comment
  String generateRandomComment() {
    var random = Random();
    return "Order-${random.nextInt(9999)}";
  }

// Function to extract order ID from the response
  String getOrderIdFromResponse(String responseString) {
    // Parse the JSON response
    Map<String, dynamic> responseData = jsonDecode(responseString);
    // Assuming 'data' contains the array of orders
    List<dynamic> orders = responseData['data'];
    // Assuming each order has a 'comment' field with the format "Order-<order_id>"
    String lastComment = orders.last['comment'];
    // Extract order ID from the comment
    return lastComment.substring(lastComment.indexOf('-') + 1);
  }

  @override
  void initState() {
    super.initState();
    final menuIdentityController = Get.find<MenuIdentityController>();
    final retrievedMenuId = menuIdentityController.menuId;
    fetchMenuDetails(retrievedMenuId);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final MenuIdentityController menuIdentityController =
        Get.find<MenuIdentityController>();
    int retrievedMenuId = menuIdentityController.menuId;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: 900,
            child: Stack(
              children: [
                Image.asset(
                  'assets/Group 1410088239.png',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 380,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 50, right: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "We've estimated time is 8mins, you can\ncollect your order after 8mins asap",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 21,
                                    color: Color(0xff6B7280),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Your total is \$${cartProvider.getTotalPrice().toStringAsFixed(2)}', // Update this line
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Button(
                              child: const Center(
                                child: Text(
                                  'Pay Cash',
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                              ),
                              gradient: const LinearGradient(colors: [
                                Color(0xffC3B39E),
                                Color(0xff725E45),
                              ]),
                              onTap: () {
                                placeOrder(context);
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Image.asset('assets/Divider.png'),
                            const SizedBox(
                              height: 25,
                            ),
                            Button(
                                child: const Center(
                                  child: Text(
                                    'Other Payment Method',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ),
                                gradient: const LinearGradient(colors: [
                                  Color(0xffC3B39E),
                                  Color(0xff725E45),
                                ]),
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: "Unable to load the payment gateways, please ensure the app is in production",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
