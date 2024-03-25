import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:garttitude_coffee/cart_screen/cart_screen.dart';
import 'package:garttitude_coffee/cart_screen/checkout_screen.dart';
import 'package:garttitude_coffee/constants/mainbutton.dart';
import 'package:garttitude_coffee/favourite/favourite_screen.dart';
import 'package:garttitude_coffee/provider/getx_menuid.dart';
import 'package:garttitude_coffee/provider/product_data_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:http/http.dart' as http;

class ProductDetailsController {
  late int _menuId;

  void setMenuId(int id) {
    _menuId = id;
  }

  int get getMenuId => _menuId;
}

class ProductDetailsScreen extends StatefulWidget {
  final int menuId;

  ProductDetailsScreen({Key? key, required this.menuId}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

 
  

  void _addToCart() {
  Map<String, dynamic> productData = {
    'menuId': _menuId,
    'menuName': _menuName,
    'menuDescription': _menuDescription,
    'menuPrice': _menuPrice,
    'quantity': _counter,
    'topping': hpTypeValue ?? 'None',
    'size': selectedSize ?? 'Regular',
  };
     Provider.of<ProductDataProvider>(context, listen: false)
              .setProductData(productData);
  // You can send the productData to the Cart Screen here
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Cart_Screen(productData: productData),
    ),
  );
  Provider.of<ProductDataProvider>(context, listen: false)
              .setProductData(productData);
}


void _buyNow() {
  Map<String, dynamic> productData = {
    'menuId': _menuId,
    'menuName': _menuName,
    'menuDescription': _menuDescription,
    'menuPrice': _menuPrice,
    'quantity': _counter,
    'topping': hpTypeValue ?? 'None',
    'size': selectedSize ?? 'Regular',
  };
    Provider.of<ProductDataProvider>(context, listen: false)
              .setProductData(productData);
  // You can send the productData to the Checkout Screen here
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CheckOutScreen(productData: productData),
    ),
  );
}

 final MenuIdentityController menuController = Get.find<MenuIdentityController>();



  late int _menuId;
  late String _menuName;
  late String _menuDescription;
  late double _menuPrice;
  late int _minimumQty;
  late bool _menuStatus;
  late int _menuPriority;
  late String _createdAt;
  late String _updatedAt;
  late int _stockQty;
  late List<dynamic> _stocks;
  late String _currency;
  late final ProductDetailsController controller;
  Color _colorcoldContainer = Colors.white;
  Color _colorcoldContainer2 = Colors.white;
  Color _colorcoldContainer3 = Colors.white;
  List<String> hpType = [
    'Whipped Cream',
    'Marshmallow',
    'Nutella',
    'Cream',
    'None',
  ];
  String? hpTypeValue;
  int _counter = 0;

  List<String> sizeOptions = ['Regular', 'Large', 'Xtra Large'];
  String? selectedSize;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter = max(_counter - 1, 0);
    });
  }

  @override
  void initState() {
    super.initState();
    _menuId = widget.menuId;
    fetchMenuDetails(_menuId);
      controller = ProductDetailsController();
    controller.setMenuId(widget.menuId);
    menuController.setMenuId(widget.menuId);
  }

  void fetchMenuDetails(int menuId) async {
    final url = Uri.parse('http://157.245.111.134/tastyig/api/menus/$menuId');
      
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        final Map<String, dynamic> data = jsonResponse['data'];
        final Map<String, dynamic> attributes = data['attributes'];

        setState(() {
          _menuId = attributes['menu_id'];
          _menuName = attributes['menu_name'];
          _menuDescription = attributes['menu_description'];
          _menuPrice = attributes['menu_price'].toDouble();
          _minimumQty = attributes['minimum_qty'];
          _menuStatus = attributes['menu_status'];
          _menuPriority = attributes['menu_priority'];
          _createdAt = attributes['created_at'];
          _updatedAt = attributes['updated_at'];
          _stockQty = attributes['stock_qty'];
          _stocks = attributes['stocks'];
          _currency = attributes['currency'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during API call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/Image_Background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _menuName ?? '',
style: GoogleFonts.getFont(
  'Roboto',
  fontSize: 20,
  fontWeight: FontWeight.bold,
),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _menuDescription ?? '',
                      style: GoogleFonts.getFont(
  'Roboto',
  fontSize: 20,
  fontWeight: FontWeight.bold,
),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price: $_menuPrice $_currency',
                         style: GoogleFonts.getFont(
  'Roboto',
  fontSize: 20,
  fontWeight: FontWeight.bold,
),
                          ),
                          Text(
                            'Stock: $_stockQty',
                           style: GoogleFonts.getFont(
  'Roboto',
  fontSize: 20,
  fontWeight: FontWeight.bold,
),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          GradientText(
                            'Size',
                      style: GoogleFonts.getFont(
  'Roboto',
  fontSize: 20,
  fontWeight: FontWeight.bold,
),
                            colors: [
                              Color(0xff9D9080),
                              Color(0xffC3B39E),
                              Color(0xff725E45),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: sizeOptions.map((size) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedSize = size;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 16),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                decoration: BoxDecoration(
                                  color: selectedSize == size
                                      ? Color(0xff9D9080)
                                      : Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  size,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: selectedSize == size
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          GradientText(
                            'Topping',
                       style: GoogleFonts.getFont(
  'Roboto',
  fontSize: 20,
  fontWeight: FontWeight.bold,
),
                            colors: [
                              Color(0xff9D9080),
                              Color(0xffC3B39E),
                              Color(0xff725E45),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField(
                        value: hpTypeValue,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              EdgeInsets.only(top: 16, left: 16, right: 16),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        isExpanded: true,
                        hint: Text(
                          'Select Topping',
                          style: TextStyle(fontSize: 16),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                        items: hpType.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            hpTypeValue = value as String?;
                          });
                        },
                        onSaved: (value) {
                          hpTypeValue = value as String?;
                        },
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GradientText(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w500,
                            ),
                            colors: [
                              Color(0xff9D9080),
                              Color(0xffC3B39E),
                              Color(0xff725E45),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _decrementCounter();
                                },
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xffC3B39E),
                                          Color(0xff725E45),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              GradientText(
                                '$_counter',
                                style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                colors: [
                                  Color(0xff9D9080),
                                  Color(0xffC3B39E),
                                  Color(0xff725E45),
                                ],
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  _incrementCounter();
                                },
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xffC3B39E),
                                          Color(0xff725E45),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Hi there, if you have any special instructions please write',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff9CA3AF),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffE4DFDF).withOpacity(0.3),
                        ),
                        child: TextFormField(
                          maxLines: 4,
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
                              borderSide: BorderSide(
                                color: Color(0xff6B7280).withOpacity(0.3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff6B7280).withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            border: InputBorder.none,
                            hintText: 'Type Here',
                            hintStyle: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: Button(
                          child: Center(
                            child: Text(
                              'Buy Now',
                             style: GoogleFonts.getFont(
  'Roboto',
  fontSize: 20,
  fontWeight: FontWeight.bold,
),
                            ),
                          ),
                          gradient: LinearGradient(
                            colors: [Color(0xffC3B39E), Color(0xff725E45)],
                          ),
                          onTap: () {
                            final productData = {
            'menuId': _menuId,
            'menuName': _menuName,
            'menuDescription': _menuDescription,
            'menuPrice': _menuPrice,
            'quantity': _counter,
            'topping': hpTypeValue ?? 'None',
            'size': selectedSize ?? 'Regular',
          };
          Provider.of<ProductDataProvider>(context, listen: false)
              .setProductData(productData);
         Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CheckOutScreen(productData: productData),
    ),
  );
                          },
                        ),
                        
                      ),
                      SizedBox(height: 16),
                          Align(
                        alignment: Alignment.center,
                        child: Button(
                          child: Center(
                            child: Text(
                              'Add to Cart',
                             style: GoogleFonts.getFont(
  'Roboto',
  fontSize: 20,
  fontWeight: FontWeight.bold,
),
                            ),
                          ),
                          gradient: LinearGradient(
                            colors: [Color(0xffC3B39E), Color(0xff725E45)],
                          ),
                          onTap: () {
                               final productData = {
            'menuId': _menuId,
            'menuName': _menuName,
            'menuDescription': _menuDescription,
            'menuPrice': _menuPrice,
            'quantity': _counter,
            'topping': hpTypeValue ?? 'None',
            'size': selectedSize ?? 'Regular',
          };
          Provider.of<ProductDataProvider>(context, listen: false)
              .setProductData(productData);
               Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CheckOutScreen(productData: productData),
    ),
  );
                          },

                        ),
                        
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}