import 'package:flutter/material.dart';

class Img {
  String img;
  String price;
  String coffeename;

  Img(
    this.img,
    this.price,
    this.coffeename,
  );
}

class Checkout_details {
  String images;
  String time;
  String product;
  String discription;
  String price;

  Checkout_details(
    this.images,
    this.time,
    this.product,
    this.discription,
    this.price,
  );
}

class BonusPoints {
  String pic;
  String refer;
  String det;
  String code;

  BonusPoints(
    this.pic,
    this.refer,
    this.det,
    this.code,
  );
}

final List<BonusPoints> bonuspoints = [
  BonusPoints('assets/b1.png', 'Refer a Friend',
      'Get a FREE rail cocktail for you and your friend!', 'Get Code'),
  BonusPoints('assets/b3.png', 'Birthday Treat',
      'It’s your birthday so have a drink  up to \$5 on us! ', 'Get Code'),
  BonusPoints('assets/b2.png', 'Double Points on Milk Coffee',
      'Milk Coffee is double points for the month of March', 'Get Code')
];

class Rewards {
  String pics;
  String title;
  String dis;
  final Container;

  Rewards(
    this.pics,
    this.title,
    this.dis,
    this.Container,
  );
}

final List<Rewards> rewards = [
  Rewards(
      'assets/r1.png',
      'Mystery Shot',
      'Bartender’s choice of liquor',
      Container(
        height: 28,
        width: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient:
              LinearGradient(colors: [Color(0xffC3B39E), Color(0xff725E45)]),
        ),
        child: Center(
          child: Text(
            '25 points',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      )),
  Rewards(
      'assets/r2.png',
      'Cold Coffee',
      'Choice of High Life, Pabst, or Shlitz',
      Container(
        height: 28,
        width: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient:
              LinearGradient(colors: [Color(0xffC3B39E), Color(0xff725E45)]),
        ),
        child: Center(
          child: Text(
            '30 points',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      )),
  Rewards(
      'assets/r3.png',
      'Gratitude Special Coffee',
      'Try our special coffee to get points',
      Container(
        height: 28,
        width: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient:
              LinearGradient(colors: [Color(0xffC3B39E), Color(0xff725E45)]),
        ),
        child: Center(
          child: Text(
            '35 Points',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      )),
];
