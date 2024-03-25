

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:garttitude_coffee/address_screen/address_screen.dart';
import 'package:garttitude_coffee/loyalityreward_screens/reward_earn.dart';
import 'package:garttitude_coffee/notifications_screen/notification_screen.dart';
import 'package:garttitude_coffee/payment_screens/paymentmethod_screen.dart';
import 'package:garttitude_coffee/profile_screens/contact_screen.dart';
import 'package:garttitude_coffee/profile_screens/editpassword_screen.dart';
import 'package:garttitude_coffee/profile_screens/profile_screen.dart';
import 'package:garttitude_coffee/provider/product_data_provider.dart';
import 'package:garttitude_coffee/term&conditions_screen/term&condition_screen.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../cart_screen/cart_screen.dart';
import '../constants/listsdata.dart';
import '../favourite/favourite_screen.dart';
import '../homescreen/homescreen.dart';
import '../orders_screens/activeorders_screen.dart';

class Settings_Screen extends StatefulWidget {
   
  Settings_Screen({super.key});

  @override
  State<Settings_Screen> createState() => _Settings_ScreenState();
}

class _Settings_ScreenState extends State<Settings_Screen> {

String firstName = '';
String lastName = '';



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

 @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
      final productData =
        Provider.of<ProductDataProvider>(context).productData;
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  Cart_Screen(productData: productData,)));
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
                          'assets/set.png',
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          "Settings",
                          style:
                              TextStyle(color: Color(0xffC3B39E), fontSize: 12),
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
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '',
                  ),
                  const Text(
                    'Settings',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                   NotificationScreen()));
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
                          child: const Icon(
                            Icons.notifications_outlined,
                            size: 25,
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/Ellipse 1.png',
                    scale: 0.7,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: GradientText(
                            'Hi, $firstName',
                            style: const TextStyle(
                                fontSize: 23.0, fontWeight: FontWeight.w500),
                            colors: [
                              const Color(0xff9D9080),
                              const Color(0xffC3B39E),
                              const Color(0xff725E45),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Welcome there,',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'View Profile',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 20,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddressScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Address',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 20,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Column(
                          children: [
                            const Text(
                              'Rate Our  App',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            const Text(
                              'Rate us according to your experience\nwith garttitude coffee',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Color(0xff9D9080),
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Rate Us',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 22,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RewardEarn()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Loyality Reward',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 22,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'View and change email',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 22,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditPasswordScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Change password',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 22,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentMethodScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Manage Payment Methods',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 22,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ActiveOrdersScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order History',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 22,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'View and edit birthday',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 22,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Contact Us',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 22,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TermsAndCondition()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Terms & Conditions',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 22,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
