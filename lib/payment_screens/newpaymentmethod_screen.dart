import 'package:flutter/material.dart';
import 'package:garttitude_coffee/constants/textfields.dart';
import 'package:garttitude_coffee/payment_screens/paymentmethod_confirm.dart';

import '../constants/mainbutton.dart';

class NewPaymentMethod extends StatelessWidget {
  const NewPaymentMethod({super.key});

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
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    'New Payment Method',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const Text(
                    'Payment Information',
                    style: TextStyle(fontSize: 29, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Please Enter Complete Payment information to link your account.',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6B7280)),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFields(
                hintText: 'Cardholder Name',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFields(
                hintText: 'Card Number',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFields(
                hintText: 'CVV',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFields(
                hintText: 'Valid Until(mm/yy)',
              ),
              const SizedBox(
                height: 120,
              ),
              Button(
                  child: const Center(
                    child: Text(
                      'Link Account',
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
                                const PaymentMethodConfirm()));
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
