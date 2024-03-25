import 'package:flutter/material.dart';

class TextFields extends StatefulWidget {
  final hintText;
  final Icon? pre;
  final Icon? suf;
  final TextEditingController? controller;
  TextFields(
      {super.key,
      @required this.hintText,
      @required this.pre,
      @required this.suf,
      @required this.controller});

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {

  

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffE4DFDF).withOpacity(0.3),
      ),
      child: TextFormField(
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
              borderSide:
                  BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
          border: InputBorder.none,
          hintText: widget.hintText,
          prefixIcon: widget.pre,
          suffixIcon: widget.suf,
          hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
        ),
      ),
    );
  }
}

class TextFields_ForPasswords extends StatefulWidget {
  final hintTexts;
  final Icon? pre;
final TextEditingController? controller;
  TextFields_ForPasswords(
      {super.key, @required @required this.hintTexts, this.pre, this.controller});

  @override
  State<TextFields_ForPasswords> createState() =>
      _TextFields_ForPasswordsState(hintTexts, pre);
}

class _TextFields_ForPasswordsState extends State<TextFields_ForPasswords> {
  @override
  final hintTexts;
  final Icon? pref;

  TextEditingController passwordLogincontroller = TextEditingController();

  _TextFields_ForPasswordsState(this.hintTexts, this.pref);

  @override
  void initState() {
    _passwordVisible = false;
  }


  

  bool? _passwordVisible;

  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffE4DFDF).withOpacity(0.3),
      ),
      child: TextFormField(
        controller: passwordLogincontroller,
        obscureText: !_passwordVisible!,
        obscuringCharacter: '*',
        cursorColor: Colors.orange,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xff6B7280).withOpacity(0.3),
              ),
            ),
            disabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color(0xff6B7280).withOpacity(0.3))),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color(0xff6B7280).withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
            hintText: hintTexts,
            prefixIcon: pref,
            hintStyle: TextStyle(color: Color(0xff9E9E9E), fontSize: 18),
            suffixIcon: IconButton(
              icon: Icon(
                  _passwordVisible! ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible!;
                });
              },
            ),
            labelStyle: const TextStyle(
                color: Color(0xffAAAAAA),
                fontSize: 19,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
