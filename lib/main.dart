import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garttitude_coffee/cart_screen/checkout_screen.dart';
import 'package:garttitude_coffee/firebase_options.dart';
import 'package:garttitude_coffee/homescreen/selected_menu.dart';
import 'package:garttitude_coffee/login&singup_screens/splashscreen.dart';
import 'package:garttitude_coffee/provider/getx_menuid.dart';
import 'package:garttitude_coffee/provider/my_app_provider.dart';
import 'package:garttitude_coffee/provider/product_data_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 final MenuIdentityController menuController = Get.put(MenuIdentityController());
 Get.put(TimeSlotController()); 
   runApp(
    Builder(
      builder: (context) => MyAppProvider(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      home: SplashScreen(),
    );
  }
}