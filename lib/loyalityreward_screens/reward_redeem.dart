import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garttitude_coffee/constants/listsdata.dart';
import 'package:garttitude_coffee/loyalityreward_screens/getcode.dart';
import 'package:garttitude_coffee/loyalityreward_screens/reward_earn.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../constants/mainbutton.dart';

class RewardRedeem extends StatefulWidget {
  const RewardRedeem({super.key});

  @override
  State<RewardRedeem> createState() => _RewardRedeemState();
}

class _RewardRedeemState extends State<RewardRedeem> {

   int? userBalance; // Variable to hold the user's balance

  @override
  void initState() {
    super.initState();
    // Call a function to fetch user balance when the widget initializes
    fetchUserBalance();
  }

  // Function to fetch user balance from Firestore
  void fetchUserBalance() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Check if user is logged in
    if (user != null) {
      // Get the user's UID
      String uid = user.uid;

      // Access Firestore collection and document to retrieve user balance
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('loyalty_points')
          .doc(uid)
          .get();

      // Check if the document exists and retrieve the balance
      if (userSnapshot.exists) {
        setState(() {
          // Update the userBalance variable with the fetched balance
          userBalance = userSnapshot['balance'];
        });
      }
    }
  }




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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RewardEarn()));
                        },
                        child: Container(
                            height: 54,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Color(0xffEAEAEA),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            child: const Center(
                              child: Text(
                                'Earn',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff5E5E5E)),
                              ),
                            )),
                      ),
                    ),
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
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: const Center(
                            child: Text(
                              'Redeem',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GradientText(
                '$userBalance' ?? 'loading...',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 26.0, fontWeight: FontWeight.w400),
                colors: [
                  const Color(0xff9D9080),
                  const Color(0xffC3B39E),
                  const Color(0xff725E45),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GradientText(
                'Bad Moon Points',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.w400),
                colors: [
                  const Color(0xff9D9080),
                  const Color(0xffC3B39E),
                  const Color(0xff725E45),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  const Text(
                    'Gratitude Coffee Rewards',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: rewards.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      child: Container(
                        height: 210,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  rewards[index].pics,
                                  scale: 0.7,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          GradientText(
                                            rewards[index].title,
                                            style: const TextStyle(
                                                fontSize: 15.0,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: GradientText(
                                          rewards[index].dis,
                                          style: const TextStyle(
                                              fontSize: 12.0,
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
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: rewards[index].Container,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const GetCode()));
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xffC3B39E),
                                      Color(0xff725E45)
                                    ]),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                                child: const Center(
                                    child: Text(
                                  'Redeem Now',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
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
