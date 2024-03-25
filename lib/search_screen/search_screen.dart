import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:garttitude_coffee/constants/textfields.dart';

import '../constants/listsdata.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isFavorited = false;
  bool _isFavorited2 = false;
  @override
  final List<Img> coffee = [
    Img(
      "assets/search2.png",
      '15',
      'Black Coffee',
    ),
    Img(
      "assets/search1.png",
      '30',
      'Cold Coffee',
    ),
  ];

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.grey.withOpacity(0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/profile.png',
                      scale: 0.8,
                    ),
                    Card(
                        elevation: 8,
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
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              TextFields(
                  hintText: 'Search for Coffee..',
                  pre: const Icon(
                    Icons.search_outlined,
                    size: 28,
                  )),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  const Text(
                    'Recently searched',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                height: 69,
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: <Widget>[
                      ButtonsTabBar(
                        radius: 8,
                        height: 55,
                        borderWidth: 1,
                        borderColor: const Color(0xff9E9E9E).withOpacity(0.5),
                        unselectedBorderColor:
                            const Color(0xff9E9E9E).withOpacity(0.5),
                        backgroundColor: Colors.white,
                        unselectedBackgroundColor: Colors.white,
                        unselectedLabelStyle:
                            const TextStyle(color: Colors.black),
                        labelStyle:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        tabs: [
                          const Tab(
                            text: "       Ice Tea       ",
                          ),
                          const Tab(
                            text: "      Coffee      ",
                          ),
                          const Tab(
                            text: "  Chocolate    ",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Most Popular',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff8D8D8D)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: coffee.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 255,
                    crossAxisSpacing: 12),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(children: [
                        Stack(
                          children: [
                            Image.asset(
                              coffee[index].img,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 184,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(
                                        () => _isFavorited = !_isFavorited);
                                  },
                                  icon: _isFavorited
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Color(0xff9D9080),
                                          size: 28,
                                        )
                                      : const Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        coffee[index].coffeename,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Text(
                                          '\$',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff9D9080),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 50),
                                        child: Text(
                                          coffee[index].price,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            color: Color(0xff9D9080),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xff9D9080),
                                      Color(0xff725E45),
                                    ]),
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            ])
                      ]));
                },
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
