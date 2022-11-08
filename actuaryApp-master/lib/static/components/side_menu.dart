import 'package:actuaryapp/constants.dart';
import 'package:actuaryapp/menu_controller.dart';
import 'package:actuaryapp/static/components/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  final MenuController _controller = Get.find<MenuController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kDarkBlackColor,
        child: Obx(
          () => ListView(
            children: [
              DrawerHeader(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 3.5,
                  ),
                  child: Text(
                    "Logo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ...List.generate(
                _controller.menuItems.length,
                (index) => SideMenuItem(
                  title: _controller.menuItems[index],
                  isActive: index == _controller.selectedIndex,
                  press: () {
                    _controller.setMenuIndex(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
