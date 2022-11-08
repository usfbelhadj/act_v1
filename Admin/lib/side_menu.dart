import 'package:actuaryadmin/screens/dashboard/dashboard_screen.dart';
import 'package:actuaryadmin/screens/login/login_screen.dart';
import 'package:actuaryadmin/screens/profile/profile_screen.dart';
import 'package:actuaryadmin/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SideMenu extends StatelessWidget {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text("Logo"),
          ),
          DrawerListTile(
            title: "Dashbord",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => DashboardScreen()));
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
          DrawerListTile(
            title: "Logout",
            svgSrc: "assets/icons/menu_logout.svg",
            press: () {
              _prefs.then((SharedPreferences prefs) {
                prefs.reload();
                var token = prefs.getString('token');
                if (token != null) {
                  prefs.remove('token');
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
                print("logout");
              });
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
