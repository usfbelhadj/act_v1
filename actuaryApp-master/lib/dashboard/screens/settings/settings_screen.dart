import 'package:flutter/material.dart';
import '../../../responsive.dart';
import 'components/settings.dart';
import '../../side_menu.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _controller.scaffoldKey,
      drawer: DashboardSideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: DashboardSideMenu(),
              ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                //padding: EdgeInsets.all(defaultPadding),
                child: Settings(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
