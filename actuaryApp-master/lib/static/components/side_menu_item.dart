import 'package:actuaryapp/constants.dart';
import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback press;

  const SideMenuItem({
    Key? key,
    required this.title,
    required this.isActive,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
        ),
        selected: isActive,
        selectedTileColor: kPrimaryColor,
        onTap: press,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
