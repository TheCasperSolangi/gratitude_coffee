import 'dart:convert';
import 'dart:math';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garttitude_coffee/models/menu_models.dart';
import 'package:garttitude_coffee/notifications_screen/notification_screen.dart';
import 'package:garttitude_coffee/search_screen/search_screen.dart';
import 'package:http/http.dart' as http;
import 'package:garttitude_coffee/cart_screen/cart_screen.dart';
import 'package:garttitude_coffee/cart_screen/productdetails_screen.dart';
import 'package:garttitude_coffee/constants/bottomnavigationbar_screen.dart';
import 'package:garttitude_coffee/homescreen/homescreen.dart';
import 'package:garttitude_coffee/orders_screens/activeorders_screen.dart';
import 'package:garttitude_coffee/settings_screen/settings_screen.dart';

import '../constants/listsdata.dart';
import '../profile_screens/profile_screen.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late String userId = '';
   late List<Menu> menus = [];
  bool _isFavorited = false;
  bool _isFavorited2 = false;

  @override
  void initState() {
    super.initState();
    fetchData();
    _showFetchingDialog();
    
  }

 // Function to retrieve the user ID from Firebase Authentication
  Future<void> retrieveUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    }
  }




  Future<void> _showFetchingDialog() async {
    // Delay duration between 2 and 6 seconds
    final random = Random();
    final delaySeconds = random.nextInt(5) + 2;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Fetching products please wait'),
        );
      },
    );

    await Future.delayed(Duration(seconds: delaySeconds));

    Navigator.of(context).pop(); // Close the dialog after delay
  }

 // Initialize userId as an empty string
  Future<void> fetchData() async {
    final url = Uri.parse('http://157.245.111.134/tastyig/api/menus');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        final List<dynamic>? jsonData = jsonResponse['data'];

        if (jsonData != null) {
          final List<Menu> fetchedMenus = [];
          for (var item in jsonData) {
            final menu = Menu.fromJson(item['attributes']);
            fetchedMenus.add(menu);
          }
          setState(() {
            menus = fetchedMenus;
          });
        } else {
          throw Exception('Menus data is null');
        }
      } else {
        throw Exception('JSON response is null');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
  // Function to add favorite menu to Firebase
  Future<void> addFavoriteMenu(int menuId) async {
    retrieveUserId();
    final String documentId = UniqueKey().toString(); // Generate random document ID

    // Add favorite menu to Firestore
    await FirebaseFirestore.instance
        .collection('favorite_menus')
        .doc(documentId)
        .set({
      'menuId': menuId,
      'userId': userId,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomN(),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 17, right: 17, top: 30),
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/profile.png',
                          scale: 0.8,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationScreen(),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.notifications_outlined,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffE4DFDF).withOpacity(0.3),
                  ),
                  child: TextFormField(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: const Color(0xff6B7280).withOpacity(0.3),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xff6B7280).withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xff6B7280).withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 19, horizontal: 20),
                      border: InputBorder.none,
                      hintText: 'Search for Coffee..',
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xff9E9E9E),
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  height: 80,
                  child: DefaultTabController(
                    length: 4,
                    child: Column(
                      children: <Widget>[
                        ButtonsTabBar(
                          radius: 8,
                          height: 55,
                          borderWidth: 1,
                          borderColor: const Color(0xff9E9E9E),
                          unselectedBorderColor: const Color(0xff9E9E9E),
                          backgroundColor: const Color.fromARGB(255, 158, 138, 113),
                          unselectedBackgroundColor: const Color(0xffF1F1F1),
                          unselectedLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          tabs: [
                            const Tab(
                              text: "    Hot Coffee    ",
                            ),
                            const Tab(
                              text: "   Cold Coffee   ",
                            ),
                            const Tab(
                              text: "             Tea             ",
                            ),
                            const Tab(
                              text: "  Chocolate Tea  ",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: menus.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final menu = menus[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(menuId: menu.menuId),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                child: Image.asset(
                                  'assets/cover.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    menu.menuName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    menu.menuDescription,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${menu.menuPrice.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF6B4E32),
                                        ),
                                      ),
                                        IconButton(
                                  onPressed: () {
                                    setState(() {
                                      menu.isFavorite = !menu.isFavorite;
                                    });
                                    addFavoriteMenu(menu.menuId); // Add this line
                                  },
                                  icon: Icon(
                                    menu.isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: menu.isFavorite ? Colors.red : Colors.grey,
                                  ),
                                ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: const [
                    Text(
                      'Favorite',
                      style: TextStyle(fontSize: 23, color: Color(0xff8D8D8D)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: menus.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 255,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final menu = menus[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsScreen(menuId: menu.menuId),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/cover.jpg',
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: 184,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        menu.isFavorite = !menu.isFavorite;
                                      });
                                    },
                                    icon: menu.isFavorite
                                        ? const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 28,
                                    )
                                        : const Icon(
                                      Icons.favorite,
                                      color: Color(0xff9D9080),
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
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(menuId: menu.menuId),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          menu.menuName,
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
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 50),
                                          child: Text(
                                            menu.menuPrice.toString(),
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
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff9D9080),
                                        Color(0xff725E45),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}