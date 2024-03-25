import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garttitude_coffee/constants/mainbutton.dart';
import 'package:garttitude_coffee/constants/textfields.dart';
import 'package:garttitude_coffee/homescreen/homescreen.dart';
import 'package:garttitude_coffee/login&singup_screens/forgetpassword_screen.dart';
import 'package:garttitude_coffee/login&singup_screens/singup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {




  
  TextEditingController passwordLogincontroller = TextEditingController();
  TextEditingController emailLoginController = TextEditingController();

@override
void initState() {
  super.initState();
  _passwordVisible = false;
  checkIfUserLoggedIn();
}

void checkIfUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('email');
  if (email != null && email.isNotEmpty) {
    // If email is not null or empty, navigate to HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}

  bool? _passwordVisible;
  String? customerID;

 
void showLoginFailedToast() {
  Fluttertoast.showToast(
    msg: "Login failed. Please check your credentials.",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}


  @override
  Widget build(BuildContext context) {
Future<void> login() async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: emailLoginController.text,
      password: passwordLogincontroller.text,
    );

    if (userCredential.user != null) {
      // Fetch user data from Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot userDoc = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        // Retrieve necessary user data
        String customerId = userDoc['customer_id'];
        String address1 = userDoc['address1'];
        String address2 = userDoc['address2'];
        String city = userDoc['city'];
        String state = userDoc['state'];
        String postalCode = userDoc['postal_code'];

        // Save user data to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('customer_id', customerId);
        prefs.setString('address1', address1);
        prefs.setString('address2', address2);
        prefs.setString('city', city);
        prefs.setString('state', state);
        prefs.setString('postal_code', postalCode);
        prefs.setString('email', emailLoginController.text);

        // Navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        print("User document does not exist in Firestore.");
        showLoginFailedToast();
      }
    } else {
      print("User not found.");
      showLoginFailedToast();
    }
  } catch (e) {
    print("Error logging in: $e");
    showLoginFailedToast();
  }
}



    final emailTextFieldController = TextFormField(
      controller: emailLoginController,
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
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
        hintText: "Email",
      ),
    );

    final passwordTextField = TextFormField(
      controller: passwordLogincontroller,
      obscureText: !_passwordVisible!,
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
          hintText: "Password",
          hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
          suffixIcon: IconButton(
            icon: Icon(
                _passwordVisible! ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible!;
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
                    'assets/l2.png',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 135, left: 30),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 48),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 570,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 30, right: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Hi There!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 28),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Image.asset(
                                    'assets/tittle.png',
                                    scale: 0.9,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 320,
                                    child: const Text(
                                      'Welcome back, Sign in to your account',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          color: Color(0xff6B7280)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              emailTextFieldController,
                              const SizedBox(
                                height: 20,
                              ),
                              passwordTextField,
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgetPasswordScreen()));
                                    },
                                    child: const Text(
                                      'Forget Password?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          color: Color(0xff9D9080)),
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
                                      'Sign In',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                  ),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xffC3B39E),
                                    Color(0xff725E45)
                                  ]),
                                  onTap: () {
                                    login();
                                  
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don’t have an account?',
                                    style: TextStyle(
                                        color: Color(0xff9E9E9E), fontSize: 20),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpScreen()));
                                    },
                                    child: const Text(
                                      ' Sign UP',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
