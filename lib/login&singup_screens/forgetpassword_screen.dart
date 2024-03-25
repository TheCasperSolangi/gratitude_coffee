import 'package:flutter/material.dart';
import 'package:garttitude_coffee/constants/mainbutton.dart';
import 'package:garttitude_coffee/constants/textfields.dart';
import 'package:garttitude_coffee/login&singup_screens/login_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 900,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/fp.png',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 100, left: 30),
                    child: Text(
                      'Password\nRecovery',
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
                        height: 410,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 25, right: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Forget Password',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 30),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Please Enter your email below',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 22,
                                        color: Color(0xff6B7280)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFields(
                                  pre: const Icon(
                                    Icons.email,
                                    size: 26,
                                    color: Color(0xff9E9E9E),
                                  ),
                                  hintText: 'Email/Phone'),
                              const SizedBox(
                                height: 15,
                              ),
                              Button(
                                  child: const Center(
                                    child: Text(
                                      'Recover',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                  ),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xffC3B39E),
                                    Color(0xff725E45)
                                  ]),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              Image.asset('assets/Divider.png'),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Back To Login',
                                      style: TextStyle(
                                          color: Color(0xff9D9080),
                                          fontSize: 21),
                                    ),
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}
