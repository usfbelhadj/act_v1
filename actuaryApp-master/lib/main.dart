import 'package:actuaryapp/constants.dart';
import 'package:actuaryapp/menu_controller.dart';
import 'package:actuaryapp/static/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard/controller.dart';
import 'dashboard/screens/dashboard/dashboard_screen.dart';

const SERVER_IP = "http://127.0.0.1:5000/";

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Controller>(Controller(), tag: "app_controller");
    Get.put<MenuController>(MenuController());
  }
}

void main() {
  UsersBinding().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool get isAlreadyLoggedIn =>
      Get.find<Controller>(tag: "app_controller").token != null;

  @override
  Widget build(BuildContext context) {
    print("My App Builded");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Actuary App',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBgColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(backgroundColor: kPrimaryColor),
        ),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: kBodyTextColor),
            bodyText2: TextStyle(color: kBodyTextColor),
            headline5: TextStyle(color: kDarkBlackColor),
            subtitle1: TextStyle(color: kPrimaryColor)),
      ),
      home: isAlreadyLoggedIn ? const DashboardScreen() : const MainScreen(),
    );
  }
}
