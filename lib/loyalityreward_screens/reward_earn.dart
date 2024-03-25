import 'package:flutter/material.dart';
import 'package:garttitude_coffee/constants/listsdata.dart';
import 'package:garttitude_coffee/loyalityreward_screens/getcode.dart';
import 'package:garttitude_coffee/loyalityreward_screens/redeemation.dart';
import 'package:garttitude_coffee/loyalityreward_screens/reward_redeem.dart';
import 'package:garttitude_coffee/loyalityreward_screens/scanqr&earn.dart';
import 'package:garttitude_coffee/secret_admin_page.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../constants/mainbutton.dart';

class RewardEarn extends StatelessWidget {
  const RewardEarn({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 35),
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
                    'Loyality Reward',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
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
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 54,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xff9D9080),
                                Color(0xff725E45),
                              ]),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          child: const Center(
                            child: Text(
                              'Earn',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  RewardRedeem()));
                        },
                        child: Container(
                            height: 54,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Color(0xffEAEAEA),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: const Center(
                              child: Text(
                                'Redeem',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff5E5E5E)),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              GradientText(
                'How to Earn Gratitude Coffee\nPoints',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 23.0, fontWeight: FontWeight.w600),
                colors: [
                  const Color(0xff9D9080),
                  const Color(0xffC3B39E),
                  const Color(0xff725E45),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'At the bottom of your receipt enter the coupon code to start adding up points. Want some extra special deals? See our featured points below they will be sure to help you score some rewards! ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, height: 1.5),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RedeemingCode()));
                },
                child: Container(
                    height: 65,
                    width: 200,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xff9D9080),
                          Color(0xff725E45),
                        ]),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        'Redeem Code',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    )),
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                'Featured Gratitude Coffee Bonus Points',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: bonuspoints.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      child: Container(
                          height: 145,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                bonuspoints[index].pic,
                                scale: 0.7,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        GradientText(
                                          bonuspoints[index].refer,
                                          style: const TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w800),
                                          colors: [
                                            const Color(0xff9D9080),
                                            const Color(0xffC3B39E),
                                            const Color(0xff725E45),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: GradientText(
                                        bonuspoints[index].det,
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                        colors: [
                                          const Color(0xff9D9080),
                                          const Color(0xffC3B39E),
                                          const Color(0xff725E45),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const GetCode()));
                                      },
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              GradientText(
                                                bonuspoints[index].code,
                                                style: const TextStyle(
                                                    fontSize: 17.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                colors: [
                                                  const Color(0xff9D9080),
                                                  const Color(0xffC3B39E),
                                                  const Color(0xff725E45),
                                                ],
                                              ),
                                              Container(
                                                height: 1,
                                                width: 65,
                                                color: const Color(0xffC3B39E),
                                              )
                                            ],
                                          ),
                                          const Icon(
                                            Icons.arrow_forward,
                                            size: 20,
                                            color: Color(0xff725E45),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              ),
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
