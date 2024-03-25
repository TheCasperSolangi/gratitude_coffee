import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:garttitude_coffee/notifications_screen/notification_details.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {


 
@override
void initState() {
    // TODO: implement initState
    
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                            ),
                          ),
                        )),
                  ),
                  const Text(
                    'Notification',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  const Text(
                    '',
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationDetails()));
                },
                child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: 135,
                      width: double.infinity,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '29 June 2023, 7.14 PM',
                                  style: TextStyle(
                                      color: Color(0xff9D9080), fontSize: 15),
                                ),
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff9D9080)),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 270,
                                  child: const Text(
                                    'Your Order has been placed, Cafe is waiting for you.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Gratitude Coffee',
                                  style: TextStyle(
                                      color: Color(0xff9D9080), fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationDetails()));
                },
                child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      height: 135,
                      width: double.infinity,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '29 June 2023, 7.14 PM',
                                  style: TextStyle(
                                      color: Color(0xff9D9080), fontSize: 15),
                                ),
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff9D9080)),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 270,
                                  child: const Text(
                                    'Your Order has been placed, Cafe is waiting for you.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Gratitude Coffee',
                                  style: TextStyle(
                                      color: Color(0xff9D9080), fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    ));
  }
}




class OrderData {
  int orderId;
  String firstName;
  String lastName;
  String email;
  String telephone;
  String comment;
  double orderTotal;
  String statusName;
  List<Map<String, dynamic>> orderTotals;
  List<Map<String, dynamic>> orderMenus;

  OrderData({
    required this.orderId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.telephone,
    required this.comment,
    required this.orderTotal,
    required this.statusName,
    required this.orderTotals,
    required this.orderMenus,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderId: json['data']['attributes']['order_id'],
      firstName: json['data']['attributes']['first_name'],
      lastName: json['data']['attributes']['last_name'],
      email: json['data']['attributes']['email'],
      telephone: json['data']['attributes']['telephone'],
      comment: json['data']['attributes']['comment'],
      orderTotal: json['data']['attributes']['order_total'],
      statusName: json['data']['attributes']['status']['status_name'],
      orderTotals: List<Map<String, dynamic>>.from(json['data']['attributes']['order_totals']),
      orderMenus: List<Map<String, dynamic>>.from(json['data']['attributes']['order_menus']),
    );
  }
}

