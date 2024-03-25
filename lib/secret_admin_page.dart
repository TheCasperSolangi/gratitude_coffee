import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AdministratorPage extends StatelessWidget {
  final BackendService _backend = BackendService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrator Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _backend.generateTimeSlots();
              },
              child: Text('Generate Slots'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _backend.generateRandomActiveCode();
              },
              child: Text('Generate New Codes'),
            ),
          ],
        ),
      ),
    );
  }
}

class BackendService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Random _random = Random();

  Future<void> generateTimeSlots() async {
    final DateTime now = DateTime.now();
    final DateTime startTime = DateTime(now.year, now.month, now.day, now.hour, 0, 0);
    final int durationInMinutes = 60;
    final int gapInMinutes = 5;

    for (int i = 0; i < durationInMinutes ~/ gapInMinutes; i++) {
      final DateTime slotTime = startTime.add(Duration(minutes: i * gapInMinutes));
      await _firestore.collection('available_slots').add({
        'time': slotTime,
        // Add more fields as needed
      });
    }
    print('Time slots generated for the next hour!');
  }

Future<void> generateRandomActiveCode() async {
  try {
    // Access Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Generate a random redemption points between 10 and 100
    Random random = Random();
    int redemptionPoints = random.nextInt(91) + 10; // Generates random number between 10 and 100

    // Generate a random code
    String code = generateRandomCode(8); // Adjust the length as needed

    // Create a document in the 'active_codes' collection
    DocumentReference activeCodeRef = firestore.collection('active_codes').doc(code);

    // Set the data for the active code document
    await activeCodeRef.set({
      'active_codes': code,
      'redemption_points': redemptionPoints,
    });

    print('Random Active Code generated successfully:');
    print('Active Code: $code');
    print('Redemption Points: $redemptionPoints');
  } catch (e) {
    print('Error generating random active code: $e');
  }
}

String generateRandomCode(int length) {
  const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
    length, (_) => charset.codeUnitAt(random.nextInt(charset.length)),
  ));
}}