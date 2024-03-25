import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:garttitude_coffee/login&singup_screens/registrationsuccess_screen.dart';

import '../constants/mainbutton.dart';

class OTPVerificationScreen extends StatefulWidget {
  OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {

    String verified_top = "7345";

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
                    'OTP',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w400),
                  ),
                  const Text(
                    '           ',
                    // style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                'OTP Verification',
                style: TextStyle(fontSize: 31, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'please enter code sent to\nemail@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6B7280)),
              ),
              const SizedBox(
                height: 40,
              ),
              OtpTextField(
                mainAxisAlignment: MainAxisAlignment.center,
                // obscureText: true,

                enabledBorderColor: const Color(0xffE9ECEF),
                margin: const EdgeInsets.all(7),
                borderWidth: 2,

                textStyle:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                numberOfFields: 4,
                enabled: true,
                borderColor: const Color(0xffE9ECEF),
                disabledBorderColor: const Color(0xffE9ECEF),
                focusedBorderColor: const Color(0xff725E45),
                showFieldAsBox: true,

                filled: true,
                fillColor: const Color.fromRGBO(0, 0, 0, 0),
                fieldWidth: 75,

                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                onSubmit: (String verificationCode) {
                  // showDialog(
                  //     context: context,
                  //     builder: (context){
                  //       return AlertDialog(
                  //               title: const Text("Verification Code"),
                  //               content: Text('Code entered is $verificationCode'),
                  //       );
                  //     }
                  // );
                }, // end onSubmit
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don’t get code?',
                    style: TextStyle(color: Color(0xff9E9E9E), fontSize: 20),
                  ),
                  const Text(
                    ' Resend',
                    style: TextStyle(color: Color(0xff9D9080), fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Button(
                  child: const Center(
                    child: Text(
                      'Verify',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                  gradient: const LinearGradient(
                      colors: [Color(0xffC3B39E), Color(0xff725E45)]),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const RegistrationSuccessScreen()));
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}
