import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garttitude_coffee/constants/mainbutton.dart';
import 'package:garttitude_coffee/orders_screens/activeorders_screen.dart';
import 'package:garttitude_coffee/payment_screens/paymentconfirmation_screen.dart';
import 'package:garttitude_coffee/provider/cart_provider.dart';
import 'package:garttitude_coffee/provider/product_data_provider.dart';
import 'package:garttitude_coffee/settings_screen/settings_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:intl/intl.dart';
import '../constants/listsdata.dart';
import '../homescreen/timep.dart';

class CheckOutScreen extends StatefulWidget {
  final Map<String, dynamic> productData;

  CheckOutScreen({Key? key, required this.productData}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late int _counter = 0;



   List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter = max(_counter - 1, 0);
    });
  }

  @override
  Widget build(BuildContext context) {

    
    final List<Checkout_details> productDetails = [
      Checkout_details(
        'assets/Background.png',
        "20-Dec-2019, 3:00 PM",
        widget.productData['menuName'],
        widget.productData['menuDescription'],
        '\$${widget.productData['menuPrice']}',
      ),
 
    ];

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 85,
          child: BottomAppBar(
            color: const Color(0xffF7F7F7),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Your Bottom Navigation Bar Items
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your Order',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: productDetails.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: Container(
                          height: 200,
                          child: Row(
                            children: [
                              Image.asset(
                                productDetails[index].images,
                                fit: BoxFit.fill,
                                width: 162,
                                height: 175,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productDetails[index].time,
                                        style: const TextStyle(
                                          color: Color(0xffA7A7A7),
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Product: ${productDetails[index].product}',
                                        style: const TextStyle(
                                          color: Color(0xff9D9080),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        productDetails[index].discription,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: Color(0xff9CA3AF),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Price: ${productDetails[index].price}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff9CA3AF),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          GradientText(
                                            'Beverages:',
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            colors: const [
                                              Color(0xff9D9080),
                                              Color(0xffC3B39E),
                                              Color(0xff725E45),
                                            ],
                                          ),
                                          const SizedBox(width: 10),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: _decrementCounter,
                                                child: Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Color(0xffC3B39E),
                                                          Color(0xff725E45),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const Icon(
                                                      Icons.minimize,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              GradientText(
                                                '$_counter',
                                                style: const TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                colors: const [
                                                  Color(0xff9D9080),
                                                  Color(0xffC3B39E),
                                                  Color(0xff725E45),
                                                ],
                                              ),
                                              const SizedBox(width: 10),
                                              InkWell(
                                                onTap: _incrementCounter,
                                                child: Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Color(0xffC3B39E),
                                                          Color(0xff725E45),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 19,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  '_  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _  _',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(fontSize: 26),
                    ),
                     Text(
                      '\$${widget.productData['menuPrice'] * _counter}',
                      style: TextStyle(fontSize: 26, color: Color(0xffB1B1B1)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _showTimePicker(context);
                  },
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff725E45).withOpacity(0.7),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: GradientText(
                          'Pick Time',
                          style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w400,
                          ),
                          colors: const [
                            Color(0xff9D9080),
                            Color(0xffC3B39E),
                            Color(0xff725E45),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Button(
                  gradient: const LinearGradient(
                    colors: [Color(0xffC3B39E), Color(0xff725E45)],
                  ),
                  child: const Center(
                    child: Text(
                      'Checkout',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                  color: Colors.white,
                  onTap: () {
                     _addToCart();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentConfirmationScreen(),
                      ),
                      
                    );
                    Provider.of<ProductDataProvider>(context, listen: false);
             
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }



  void _addToCart() {
    // Access the CartProvider and add items to the cart
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addItem(
      widget.productData['productId'] ?? '',
      widget.productData['menuName'] ?? '',
      widget.productData['menuDescription'] ?? '',
      widget.productData['menuPrice'] ?? '',
    );
  }

 void _showTimePicker(BuildContext context) {
  showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 280,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Pick Up Time',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _buildTimeSlotsFromFirestore(context),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xffC3B39E),
                    onPrimary: Colors.white,
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildTimeSlotsFromFirestore(BuildContext context) {
  final selectedTime = Get.find<TimeSlotController>().selectedTime.value;

  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('available_slots').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }

      List<Timestamp> times = [];

      final documents = snapshot.data?.docs ?? [];

      for (var document in documents) {
        final time = document['time'] as Timestamp?;
        if (time != null) {
          times.add(time);
        }
      }

      times.sort((a, b) => a.compareTo(b)); // Sort the times in ascending order

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: times.map((time) {
            final formattedTime = _formatTime(time);
            final isSelected = selectedTime == time;

            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  Get.find<TimeSlotController>().selectTime(time);
                  Navigator.pop(context); // Dismiss the bottom sheet
                },
                child: Container(
                  width: 120,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.green : const Color(0xff725E45),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      formattedTime,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? Colors.green : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    },
  );
}

String _formatTime(Timestamp time) {
  final dateTime = time.toDate();
  final formattedTime = DateFormat.jm().format(dateTime);
  return formattedTime;
}}
class TimeSlotController extends GetxController {
  var selectedTime = Rx<Timestamp?>(null);

  void selectTime(Timestamp time) {
    selectedTime.value = time;
  }
}
