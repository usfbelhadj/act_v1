import 'package:actuaryapp/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:actuaryapp/static/components/menu_item.dart';

class Menu extends StatelessWidget {
  final MenuController _controller = Get.find<MenuController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: List.generate(
          _controller.menuItems.length,
          (index) => MenuItems(
            text: _controller.menuItems[index],
            isActive: index == _controller.selectedIndex,
            press: () {
              print(index);
              _controller.setMenuIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
