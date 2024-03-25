import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final child;
  final color;
  final onTap;
  final gradient;
  Button(
      {super.key,
      @required this.child,
      @required this.color,
      @required this.onTap,
      this.gradient});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        // color: Colors.white.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 65,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: gradient,
            color: color,
          ),
          child: child,
        ),
      ),
    );
  }
}
