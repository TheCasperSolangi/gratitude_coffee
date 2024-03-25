import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garttitude_coffee/payment_screens/newpaymentmethod_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../constants/mainbutton.dart';

class NewPaymentScreenLive extends StatefulWidget {
  const NewPaymentScreenLive({super.key});

  @override
  State<NewPaymentScreenLive> createState() => _NewPaymentScreenLiveState();
}

class _NewPaymentScreenLiveState extends State<NewPaymentScreenLive> {
  @override
  String? mastercard;
  String? paypal;
  String? visa;
  String? apple;
  String? google;
  Widget build(BuildContext context) {
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
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    'Select Payment Method',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  GradientText(
                    'Your Available Payment Methods',
                    style: const TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.w500),
                    colors: [
                      const Color(0xff9D9080),
                      const Color(0xffC3B39E),
                      const Color(0xff725E45),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/mastercard.png',
                              scale: 0.8,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            const Text(
                              'FlutterWave',
                              style: TextStyle(
                                  fontSize: 23.0, color: Color(0xff062737)),
                            ),
                          ],
                        ),
                        Transform.scale(
                          scale: 1.5,
                          child: Radio(
                            toggleable: true,
                            activeColor: const Color(0xff9D9080),
                            splashRadius: 20,
                            value: 'mastercard',
                            groupValue: mastercard,
                            onChanged: (value) {
                              setState(() {
                                mastercard = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/paypal.png',
                              scale: 0.8,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            const Text(
                              'Digital Wallet',
                              style: TextStyle(
                                  fontSize: 23.0, color: Color(0xff062737)),
                            ),
                          ],
                        ),
                        Transform.scale(
                          scale: 1.5,
                          child: Radio(
                            toggleable: true,
                            activeColor: const Color(0xff9D9080),
                            splashRadius: 20,
                            value: 'paypal',
                            groupValue: paypal,
                            onChanged: (value) {
                              setState(() {
                                paypal = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/visa.png',
                              scale: 0.8,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            const Text(
                              'BNPL',
                              style: TextStyle(
                                  fontSize: 23.0, color: Color(0xff062737)),
                            ),
                          ],
                        ),
                        Transform.scale(
                          scale: 1.5,
                          child: Radio(
                            toggleable: true,
                            activeColor: const Color(0xff9D9080),
                            splashRadius: 20,
                            value: 'visa',
                            groupValue: visa,
                            onChanged: (value) {
                              setState(() {
                                visa = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/Vector.png',
                              scale: 0.8,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            const Text(
                              'Voucher',
                              style: TextStyle(
                                  fontSize: 23.0, color: Color(0xff062737)),
                            ),
                          ],
                        ),
                        Transform.scale(
                          scale: 1.5,
                          child: Radio(
                            toggleable: true,
                            activeColor: const Color(0xff9D9080),
                            splashRadius: 20,
                            value: 'apple',
                            groupValue: apple,
                            onChanged: (value) {
                              setState(() {
                                apple = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/Group.png',
                              scale: 0.8,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            const Text(
                              'Wallet',
                              style: TextStyle(
                                  fontSize: 23.0, color: Color(0xff062737)),
                            ),
                          ],
                        ),
                        Transform.scale(
                          scale: 1.5,
                          child: Radio(
                            toggleable: true,
                            activeColor: const Color(0xff9D9080),
                            splashRadius: 20,
                            value: 'google',
                            groupValue: google,
                            onChanged: (value) {
                              setState(() {
                                google = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 90,
              ),
           
                     Button(
                  child: const Center(
                    child: Text(
                      'Set Up',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                  gradient: const LinearGradient(
                      colors: [Color(0xffC3B39E), Color(0xff725E45)]),
                  onTap: () {

                 showToastMessage();
                  }),
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
  void showToastMessage() {
    Fluttertoast.showToast(
      msg: "Payment Method Cannot be added, the app is currently in the developer enviroment",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

