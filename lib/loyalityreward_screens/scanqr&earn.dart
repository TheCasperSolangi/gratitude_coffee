import 'package:flutter/material.dart';
import 'package:garttitude_coffee/loyalityreward_screens/reward_earn.dart';

import '../constants/mainbutton.dart';

class ScanQRAndEarn extends StatelessWidget {
  const ScanQRAndEarn({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            body: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  )),
                            ),
                            const Text(
                              'Scan QR',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            Image.asset('assets/run.png'),
                          ],
                        ),
                        Image.asset(
                          'assets/rrr.png',
                          scale: 0.7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: Button(
                              child: const Center(
                                child: Text(
                                  'Scan Now',
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
                                            const RewardEarn()));
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}