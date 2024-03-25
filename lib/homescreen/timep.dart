import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  DateTime time = DateTime(2016, 5, 10, 22, 35);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    padding: const EdgeInsets.only(top: 8.0),
                    color: Colors.white,
                    child: CupertinoDatePicker(
                      initialDateTime: time,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: false,
                      // This is called when the user changes the time.
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() => time = newTime);
                      },
                    ),
                  );
                });
          },
          child: const Text("Pick time"),
        ),
      ),
    );
  }
}
