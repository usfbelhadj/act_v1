import 'package:actuaryapp/constants.dart';
import 'package:actuaryapp/menu_controller.dart';
import 'package:actuaryapp/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cta_button.dart';
import 'menu.dart';

class Header extends StatelessWidget {
  final MenuController _controller = Get.find<MenuController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kDarkBlackColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: kMaxWidth,
              ),
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (!Responsive.isDesktop(context))
                        IconButton(
                          onPressed: () {
                            _controller.toggleDrawer(context);
                          },
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                      //Icon
                      Text(
                        "Logo",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      if (Responsive.isDesktop(context)) Menu(),
                      Spacer(),
                      CTA(),
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Text(
                    "ASSOCIATION TUNISIENNE DES ACTUAIRES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: Text(
                      "Bienvenue dans le site officiel de l'Association Tunisienne des Actuaires",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        height: 1.5,
                      ),
                    ),
                  ),
                  FittedBox(
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "Learn More",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          SizedBox(width: defaultPadding / 2),
                          Icon(
                            Icons.arrow_forward,
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
