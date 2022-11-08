import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class MenuController extends GetxController {
  RxInt _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  List<String> get menuItems => [
        "Accueil",
        "A propos",
        "Activites de l'ATA",
        "Documentation",
        "Bureau Executive",
        "Contact",
      ];

  // GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void toggleDrawer(context) {
    if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).openEndDrawer();
    } else {
      Scaffold.of(context).openDrawer();
    }
  }

  void setMenuIndex(int index) {
    _selectedIndex.value = index;
  }
}
