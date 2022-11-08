import 'package:flutter/material.dart';
import '../../../responsive.dart';
import 'components/dashboard_main.dart';
import '../../side_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen();
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                child: DashboardMain(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}