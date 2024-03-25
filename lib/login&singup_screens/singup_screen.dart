import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:garttitude_coffee/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garttitude_coffee/constants/base.dart';
import 'package:garttitude_coffee/constants/mainbutton.dart';
import 'package:garttitude_coffee/constants/textfields.dart';
import 'package:garttitude_coffee/homescreen/homescreen.dart';
import 'package:garttitude_coffee/login&singup_screens/login_screen.dart';
import 'package:garttitude_coffee/login&singup_screens/otpverification_screen.dart';
import 'package:garttitude_coffee/models/user_model.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // API Call
// our form key
  final _formkey = GlobalKey<FormState>();
  final _regAuth = FirebaseAuth.instance;

  String? response_customer_id;
  String? response_email;
  String? response_first_name;
  String? response_last_name;
  String? response_phone;
  String? response_address1;
  String? response_address2;
  String? response_state;
  String? response_status;
  String? response_postcode;
  String? country_id;
  String? response_city;

  
void signUp(BuildContext context) async {
  // Show loading dialog
  showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SpinKitCubeGrid(
              color: Theme.of(context).primaryColor, // Change color as needed
              size: 50.0,
            ),
            SizedBox(height: 20.0),
            Text("Signing Up..."),
          ],
        ),
      );
    },
  );

  try {
    UserCredential userCredential = await _regAuth.createUserWithEmailAndPassword(
      email: emailAddress.text,
      password: retypePassword.text,
    );
    
    // Dismiss loading dialog
    Navigator.pop(context);

    postDetailsToFirestore(userCredential.user!);
  } catch (e) {
    print("Error creating user: $e");
    Fluttertoast.showToast(msg: "Error creating account. Please try again.");

    // Dismiss loading dialog
    Navigator.pop(context);
  }
}
postDetailsToFirestore(User user) async {
  try {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    UserModel userModel = UserModel(
      email: emailAddress.text,
      uid: user.uid,
      firstName: firstname.text,
      last_name: lastName.text,
      address1: 'house#59, block C, sector 5/F, ibrahim goth',
      address2: 'new kaachi township',
      city: 'karachi',
      customer_id: response_customer_id,
      user_state: 'sindh',
      phoneNumber: mobile.text,
      postalCode: '213',
      country_id: "222", // Assuming this is a String value
    );

    await firebaseFirestore.collection('users').doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Successfully Created!");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  } catch (e) {
    print("Error adding user details to Firestore: $e");
    Fluttertoast.showToast(msg: "Error creating account. Please try again.");
  }
}

Future<bool> registerNow() async {
  final Map<String, dynamic> payload = {
    "first_name": firstname.text,
    "last_name": lastName.text,
    "email": emailAddress.text,
    "telephone": mobile.text,
    "newsletter": false,
    "status": true,
    "customer_group_id": "123",
    "addresses": [
      {
        "address_1": 'house#123, block C, Sector 5/F',
        "address_2": 'new karachi township',
        "city": 'karachi',
        "state": 'sindh',
        "postcode": 'asd',
        "country_id": 222
      }
    ]
  };
  final String url = 'http://157.245.111.134/tastyig/api/customers';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'token':
            '1|6p9cAjt5F2iQmK40udCecziz0rVyxx9y8KqgrlokOcAKtBRkqAx5aznUiarubOTbYAwg1U3J52G5GAuD',
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 1|P9HlpDjQuKe9fWHrdKX5ZqpyP8imB0WCpAIA1dbAn4gitW67fH38O9TUR5eK4akEW4GUevmlBw3Fzsv5',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 201) {
      print("Data sent successfully.");
      final jsonResponse = json.decode(response.body);
      // Assign your response values here
                final customerData = jsonResponse['data'];
        final customerId = customerData['attributes']['customer_id'];
        response_customer_id = customerId.toString();
      // Sign up the user
      signUp(context);

      return true;
    } else {
      print("Error: ${response.statusCode}");
      print(response.body);
      // Handle errors
      return false;
    }
  } on SocketException catch (e) {
    print("Socket Exception: $e");
    throw Exception("No internet connection. Please check your connection.");
  } on TimeoutException catch (e) {
    print("Timeout Exception: $e");
    throw Exception("Connection timeout. Please try again later.");
  } on FormatException catch (e) {
    print("Format Exception: $e");
    throw Exception("Invalid response format. Please try again later.");
  } catch (e) {
    print("Exception during HTTP request: $e");
    throw Exception("An error occurred. Please try again later.");
  }
}

  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController postalCode = TextEditingController();

    // Initialize directly to false

  TextEditingController firstname = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController retypePassword = TextEditingController();

  late bool _passwordVisible;// Initialize directly to false

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    
    final address1controller = TextFormField(
      controller: address1,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "Address 1",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );

    // Text Controllerss

    final address2controller = TextFormField(
      controller: address2,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "Address 2",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );

    // Text Controllerss

    final cityController = TextFormField(
      controller: city,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "City",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );

    // Text Controllerss

    final stateController = TextFormField(
      controller: state,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "State",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );

    // Text Controllerss

    final postcodeController = TextFormField(
      controller: postalCode,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "Postal Code",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );

    // Text Controllerss

    final firstNameController = TextFormField(
      controller: firstname,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "First Name",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );

    final secondNamecontroller = TextFormField(
      controller: lastName,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "Last Name",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );

    final emailAdd = TextFormField(
      controller: emailAddress,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "Email Address",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );

    // Password Text Fields
    final mobileNumber = TextFormField(
      controller: mobile,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xff6B7280).withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        border: InputBorder.none,
        hintText: "Mobile Number",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
    );

    final retypePass = TextFormField(
      controller: retypePassword,
      obscureText: !_passwordVisible,
      obscuringCharacter: '*',
      cursorColor: Colors.orange,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color(0xff6B7280).withOpacity(0.3),
            ),
          ),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
          hintText: "Confirm Password",
          hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
          suffixIcon: IconButton(
            icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          labelStyle: const TextStyle(
              color: Color(0xffAAAAAA),
              fontSize: 19,
              fontWeight: FontWeight.w500)),
    );

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 900,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/signups.png',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 95, left: 30),
                    child: Text(
                      'Signup',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 50),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 640,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 45, right: 20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 17,
                              ),
                              firstNameController,
                              const SizedBox(
                                height: 17,
                              ),
                              secondNamecontroller,
                              const SizedBox(
                                height: 17,
                              ),
                              emailAdd,
                              const SizedBox(
                                height: 17,
                              ),
                              mobileNumber,
                              const SizedBox(
                                height: 17,
                              ),
                              retypePass,
                              const SizedBox(
                                height: 17,
                              ),
                              Button(
                                child: const Center(
                                  child: Text(
                                    'Continue Regiseration',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ),
                                gradient: const LinearGradient(colors: [
                                  Color(0xffC3B39E),
                                  Color(0xff725E45)
                                ]),
                                onTap: () async {
    bool result = await registerNow();
    if (result) {
      signUp(context);
    }
  },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                        color: Color(0xff9E9E9E), fontSize: 20),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()));
                                    },
                                    child: const Text(
                                      ' Sign In',
                                      style: TextStyle(
                                          color: Color(0xff9D9080),
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 195),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/profilepic.png',
                          scale: 0.9,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

