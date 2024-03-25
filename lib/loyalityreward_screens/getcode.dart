import 'package:flutter/material.dart';
import 'package:garttitude_coffee/constants/textfields.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GetCode extends StatelessWidget {
  const GetCode({super.key});

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
                    'Scan Gratitude Rewards',
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
                height: 60,
              ),
              Image.asset(
                'assets/Rectangle 55.png',
                scale: 0.8,
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 330,
                child: GradientText(
                  'Present this QR code to your Gratitude bartender to Redeem your reward',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.w300),
                  colors: [
                    const Color(0xff9D9080),
                    const Color(0xffC3B39E),
                    const Color(0xff725E45),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
