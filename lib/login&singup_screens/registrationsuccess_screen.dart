import 'package:flutter/material.dart';
import 'package:garttitude_coffee/homescreen/homescreen.dart';

import '../constants/mainbutton.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 110),
          child: Column(
            children: [
              Image.asset(
                'assets/rs.png',
                scale: 0.9,
              ),
              const SizedBox(
                height: 90,
              ),
              const Text(
                'Registration Success!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: 300,
                child: const Text(
                  'Your Account has been successfully created on Gratitude Coffee Enjoy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB1B1B1)),
                ),
              ),
              const SizedBox(
                height: 85,
              ),
              Button(
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                  gradient: const LinearGradient(
                      colors: [Color(0xffC3B39E), Color(0xff725E45)]),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
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
