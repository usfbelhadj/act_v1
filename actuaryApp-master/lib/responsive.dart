import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsive({
    Key? key,
    required this.mobile,
    required this.desktop,
    required this.tablet,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 900 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constaints) {
      if (constaints.maxWidth >= 900) {
        return desktop;
      } else if (constaints.maxWidth >= 650) {
        return tablet;
      } else {
        return mobile;
      }
    });
  }
}
