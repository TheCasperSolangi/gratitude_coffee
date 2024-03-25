import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:garttitude_coffee/homescreen/homescreen.dart';
import 'package:garttitude_coffee/payment_screens/order_id_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:intl/intl.dart';
import '../constants/mainbutton.dart';

class SuccessfullPaidScreen extends StatefulWidget {
  const SuccessfullPaidScreen({super.key});

  @override
  State<SuccessfullPaidScreen> createState() => _SuccessfullPaidScreenState();
}

class _SuccessfullPaidScreenState extends State<SuccessfullPaidScreen> {
  var now = DateTime.now();
 
  var timeFormat = DateFormat('HH:mm');
 late OrderController orderController;
late String customerName = ''; // Initialize with an empty string
late String orderStatus = '';
late String orderTime = '';
late String orderDate =''; 
late String orderType = '';
late String statusName = ' ';
  late Timer timer;
  var dateFormat = DateFormat('MMMM dd, yyyy - hh:mm a'); // Updated date format

 String? orderId; // Global variable to store the most recent order ID


Future<void> fetchOrder() async {
  final url = Uri.parse('http://157.245.111.134/tastyig/api/orders');

  // Define your custom headers
  final headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer 1|P9HlpDjQuKe9fWHrdKX5ZqpyP8imB0WCpAIA1dbAn4gitW67fH38O9TUR5eK4akEW4GUevmlBw3Fzsv5'
  };

  try {
    // Get the current user's email using Firebase Authentication
    final User? user = FirebaseAuth.instance.currentUser;
    final String? currentUserEmail = user != null ? user.email : null;

    if (currentUserEmail == null) {
      print('User not logged in.');
      return;
    }

    final response = await http.get(
      url,
      headers: headers, // Pass the headers here
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> orders = data['data'];

      // Filter orders based on email and get the most recent order ID
      String? latestOrderId; // Temp variable for latest order

      for (final order in orders) {
        final String email = order['attributes']['email'];

        // Compare current user's email with order email
        if (email == currentUserEmail) {
          final String currentOrderId =
              order['attributes']['order_id'].toString();

          // If no latestOrderId set yet, or this order is more recent, update latestOrderId
          if (latestOrderId == null ||
              latestOrderId.compareTo(currentOrderId) < 0) {
            latestOrderId = currentOrderId;
          }
        }
      }

      if (latestOrderId != null) {
        orderId = latestOrderId; // Update orderId with the latest order

        print('Most recent order ID for $currentUserEmail: $orderId');

        // Call fetchOrderDetails after setting orderId
        await fetchOrderDetails();
      } else {
        print('No orders found for $currentUserEmail');
      }
    } else {
      print('Failed to load orders. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}

Future<void> fetchOrderDetails() async {

   final headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer 1|P9HlpDjQuKe9fWHrdKX5ZqpyP8imB0WCpAIA1dbAn4gitW67fH38O9TUR5eK4akEW4GUevmlBw3Fzsv5'
  };

  if (orderId == null) {
    print('Order ID is null. Please fetch order first.');
    return;
  }

  final url = Uri.parse('http://157.245.111.134/tastyig/api/orders/$orderId');

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      // Parsing the response
      final data = jsonResponse['data'];
      final attributes = data['attributes'];

      // Accessing specific attributes
      final orderId = attributes['order_id'];
      final firstName = attributes['first_name'];
      final lastName = attributes['last_name'];
      final email = attributes['email'];
      final telephone = attributes['telephone'];
      final comment = attributes['comment'];
      final payment = attributes['payment'];
       orderType = attributes['order_type'];
      final createdAt = attributes['created_at'];
      final updatedAt = attributes['updated_at'];
       orderTime = attributes['order_time'];
       orderDate = attributes['order_date'];
      final orderTotal = attributes['order_total'];
      final ipAddress = attributes['ip_address'];
      final userAgent = attributes['user_agent'];
      final statusId = attributes['status_id'];
      final assigneeId = attributes['assignee_id'];
      final assigneeGroupId = attributes['assignee_group_id'];
      final invoicePrefix = attributes['invoice_prefix'];
      final invoiceDate = attributes['invoice_date'];
      final hash = attributes['hash'];
      final processed = attributes['processed'];
      final statusUpdatedAt = attributes['status_updated_at'];
      final assigneeUpdatedAt = attributes['assignee_updated_at'];
      final orderTimeIsAsap = attributes['order_time_is_asap'];
      final deliveryComment = attributes['delivery_comment'];
       customerName = attributes['customer_name'];
      final orderTypeName = attributes['order_type_name'];
      final orderDateTime = attributes['order_date_time'];
      final formattedAddress = attributes['formatted_address'];
       statusName = attributes['status_name'];
      final currency = attributes['currency'];
      final orderTotals = attributes['order_totals'];
      final orderMenus = attributes['order_menus'];

      setState(() {
          
          statusName = attributes['status_name'];
          customerName = attributes['customer_name'];
          orderDate = attributes['order_date'];
          orderTime = attributes['order_time'];
          orderType = attributes['order_type'];
      });

      // Do whatever you need with the fetched data
      print('Order ID: $orderId');
      print('First Name: $firstName');
      print('Last Name: $lastName');
      // Print other attributes as needed...
    } else {
      print('Failed to load order. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception caught: $e');
  }
}



  @override
  void initState() {
    super.initState();
    orderController = Get.put(OrderController());

    // Initial fetch
    fetchOrder();
    
    // Timer to fetch data every 5 seconds
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => fetchOrder());
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    
   
    String orderId = orderController.getOrderId();
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                    child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.close,
                            size: 25,
                            color: Colors.grey.shade500,
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/Group 1410088204.png',
                scale: 0.9,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                child:  Text(
                  orderStatus,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB1B1B1)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Order Detail',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text('Your Order is placed on $orderDate at $orderTime for $orderType'),
              const SizedBox(
                height: 25,
              ),
               Text(
                'Customer Name: $customerName',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 25,
              ),
              Text('Order is: $statusName'),
              GradientText(
                orderId,
                style: const TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.w400),
                colors: [
                  const Color(0xff9D9080),
                  const Color(0xffC3B39E),
                  const Color(0xff725E45),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '0 Mins',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffB1B1B1)),
                  ),
                  const Text(
                    '8 Mins',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffB1B1B1)),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              LinearPercentIndicator(
                width: 365,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 80000,
                percent: 0.3,
                // center: Text("80.0%"),
                barRadius: const Radius.circular(10),
                progressColor: const Color(0xff9D9080),
                backgroundColor: const Color(0xffCACACA),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      const Text(
                        'View Receipt',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff9D9080)),
                      ),
                      Container(
                        height: 1,
                        width: 114,
                        color: const Color(0xff9D9080),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Button(
                  child: const Center(
                    child: Text(
                      'Back to Home',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                  gradient: const LinearGradient(
                      colors: [Color(0xffC3B39E), Color(0xff725E45)]),
                  onTap: () {                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );}),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
