import 'package:flutter/material.dart';
import '../../../responsive.dart';
import 'components/profile.dart';
import '../../side_menu.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Profile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
