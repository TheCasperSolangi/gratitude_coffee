import 'package:flutter/material.dart';
import 'package:garttitude_coffee/constants/mainbutton.dart';
import 'package:garttitude_coffee/constants/textfields.dart';
import 'package:garttitude_coffee/notifications_screen/notification_screen.dart';
import 'package:garttitude_coffee/settings_screen/settings_screen.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({
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
                    'assets/contact.png',
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
                          'Contact Us',
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
                        height: 463,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 35, right: 20),
                          child: Column(
                            children: [
                              TextFields(
                                hintText: 'Name',
                                pre: const Icon(Icons.person),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFields(
                                hintText: 'Email/Phone',
                                pre: const Icon(Icons.email),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                maxLines: 5,
                                cursorColor: Colors.orange,
                                decoration: InputDecoration(
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: const Color(0xff6B7280)
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xff6B7280)
                                              .withOpacity(0.3))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xff6B7280)
                                              .withOpacity(0.3)),
                                      borderRadius: BorderRadius.circular(8)),
                                  // contentPadding: EdgeInsets.symmetric(
                                  //     vertical: 20, horizontal: 20),
                                  border: InputBorder.none,
                                  hintText: "Type your message here...",
                                  hintStyle: const TextStyle(
                                      color: Color(0xff9E9E9E), fontSize: 22),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Button(
                                  child: const Center(
                                    child: Text(
                                      'Send',
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
                                                Settings_Screen()));
                                  }),
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
