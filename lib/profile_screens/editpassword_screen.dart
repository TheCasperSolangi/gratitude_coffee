import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garttitude_coffee/constants/mainbutton.dart';
import 'package:garttitude_coffee/constants/textfields.dart';
import 'package:garttitude_coffee/notifications_screen/notification_screen.dart';
import 'package:garttitude_coffee/settings_screen/settings_screen.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({
    super.key,
  });

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
Future<void> _updatePassword(String newPassword) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
      print('Password updated successfully');
    } else {
      print('User is null. Please log in again.');
    }
  } on FirebaseAuthException catch (e) {
    print('Failed to update password: ${e.code} - ${e.message}');
  } catch (e) {
    print('Failed to update password: $e');
  }
}

  @override
  Widget build(BuildContext context) {

     TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController retypePasswordController = TextEditingController();


    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 900,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/Group 1410088241.png',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color(0xffC3B39E),
                                      Color(0xff725E45),
                                    ]),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white)),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              )),
                        ),
                        const Text(
                          'Update Password',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                         NotificationScreen()));
                          },
                          child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(
                                  Icons.notifications_outlined,
                                  size: 25,
                                ),
                              )),
                        ),
                      ],
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
                              left: 20, top: 35, right: 20),
                          child: Column(
                            children: [
                              TextFields_ForPasswords(
                                hintTexts: 'old Password',
                                pre: const Icon(Icons.lock),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFields_ForPasswords(
                                hintTexts: 'New Password',
                                pre: const Icon(Icons.lock),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFields_ForPasswords(
                                hintTexts: 'Retype Password',
                                pre: const Icon(Icons.lock),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Button(
                                  child: const Center(
                                    child: Text(
                                      'Update',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    ),
                                  ),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xffC3B39E),
                                    Color(0xff725E45)
                                  ]),
                                  onTap: () {
                                  String oldPassword =
                                      oldPasswordController.text.trim();
                                  String newPassword =
                                      newPasswordController.text.trim();
                                  String retypePassword =
                                      retypePasswordController.text.trim();

                                  if (newPassword == retypePassword) {
                                    _updatePassword(newPassword);
                                 
                                  } else {
                                    // Passwords do not match, show error
                                    // Handle error as needed
                                  }
                                },),
                              const SizedBox(
                                height: 20,
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
