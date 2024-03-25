import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garttitude_coffee/constants/mainbutton.dart';

class RedeemingCode extends StatefulWidget {
  const RedeemingCode({super.key});

  @override
  State<RedeemingCode> createState() => _RedeemingCodeState();
}

class _RedeemingCodeState extends State<RedeemingCode> {

  TextEditingController redeemingCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? userId;

    void getUserUID() {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  if (user != null) {
    setState(() {
       String userUID = user.uid;
    });
        String? userUID;
    print('User UID: $userUID');

    // You can use the userUID variable here for further operations
  } else {
    print('User is not logged in.');
  }
}

       final codeRedemption = TextFormField(
      controller: redeemingCode,
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
        hintText: "Enter the code to redeem",
        hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
      ),
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
                      'Code Redemption',
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
                              codeRedemption,
                              const SizedBox(
                                height: 17,
                              ),
                                     Button(
                                child: const Center(
                                  child: Text(
                                    'Redeem Now',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ),
                                gradient: const LinearGradient(colors: [
                                  Color(0xffC3B39E),
                                  Color(0xff725E45)
                                ]),
                                onTap: () {
                                    redeemCode(context, redeemingCode.text);
                                },
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


void redeemCode(BuildContext context, String userCode) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  if (user == null) {
    Fluttertoast.showToast(msg: 'User is not authenticated.');
    return;
  }

  String uid = user.uid;

  if (uid.isEmpty) {
    Fluttertoast.showToast(msg: 'Invalid user UID.');
    return;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Redeeming Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Fetching the code...'),
            SizedBox(height: 16),
            SpinKitWave(
              color: Theme.of(context).primaryColor,
              size: 50.0,
            ),
          ],
        ),
      );
    },
  );

  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference activeCodesRef = firestore.collection('active_codes');

    QuerySnapshot querySnapshot = await activeCodesRef
        .where('active_code', isEqualTo: userCode)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      int redemptionPoints = querySnapshot.docs.first['redemption_points'];
      String activeCode = querySnapshot.docs.first.id;

      DocumentReference userLoyaltyRef = firestore.collection('loyalty_points').doc(uid);

      DocumentSnapshot userLoyaltySnapshot = await userLoyaltyRef.get();
      if (!userLoyaltySnapshot.exists) {
        await userLoyaltyRef.set({
          'uid': uid,
          'balance': 0,
        });
      }

      userLoyaltySnapshot = await userLoyaltyRef.get();
      int currentBalance = userLoyaltySnapshot['balance'];
      int newBalance = currentBalance + redemptionPoints;

      await userLoyaltyRef.update({'balance': newBalance});
      await activeCodesRef.doc(activeCode).delete();

      Navigator.of(context).pop(); // Close the loading dialog
      Fluttertoast.showToast(msg: 'Code redeemed successfully! Loyalty points added: $redemptionPoints');
    } else {
      Navigator.of(context).pop(); // Close the loading dialog
      Fluttertoast.showToast(msg: 'Invalid code: $userCode');
    }
  } catch (e) {
    Navigator.of(context).pop(); // Close the loading dialog
    if (e is FirebaseException && e.code == 'invalid-argument') {
      Fluttertoast.showToast(msg: 'Invalid document reference. Path is empty or null.');
    } else {
      Fluttertoast.showToast(msg: 'Error redeeming code: $e');
    }
  }
}