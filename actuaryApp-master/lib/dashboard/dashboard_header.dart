import 'package:actuaryapp/constants.dart';
import 'package:actuaryapp/dashboard/controller.dart';
import 'package:actuaryapp/static/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../menu_controller.dart';
import '../responsive.dart';

// ignore: must_be_immutable
class DashboardHeader extends StatelessWidget {
  final MenuController _menucontroller = Get.find<MenuController>();
  final Controller _controller = Get.find<Controller>(tag: 'app_controller');
  final title;
  DashboardHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDarkBlackColor,
      height: 50,
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              onPressed: () {
                _menucontroller.toggleDrawer(context);
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: Container(),
          ),
          ElevatedButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
                vertical:
                    defaultPadding / (Responsive.isDesktop(context) ? 1 : 2),
              ),
            ),
            onPressed: () {
              _controller.onLogout().then((value) {
                if (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                }
              });
            },
            child: Text("Logout"),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
