import 'package:actuaryadmin/constants.dart';
import 'package:actuaryadmin/screens/dashboard/dashboard_screen.dart';
import 'package:actuaryadmin/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/controller.dart';

const SERVER_IP = 'http://127.0.0.1:5000';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Controller>(Controller(), tag: "app_controller");
  }
}

void main() {
  UsersBinding().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  bool get isAlreadyLoggedIn =>
      Get.put<Controller>(Controller(), tag: "app_controller").token != null;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData.dark().copyWith(
        snackBarTheme: SnackBarThemeData(
            contentTextStyle: TextStyle(
          color: Colors.white,
        )),
        scaffoldBackgroundColor: bgColor,
        // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        //     .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: isAlreadyLoggedIn ? const DashboardScreen() : const LoginScreen(),
    );
  }
}
