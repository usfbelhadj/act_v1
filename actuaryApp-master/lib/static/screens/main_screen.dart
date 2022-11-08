import 'package:actuaryapp/constants.dart';
import 'package:actuaryapp/static/components/footer.dart';
import 'package:actuaryapp/static/components/header.dart';
import 'package:actuaryapp/static/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _controller.scaffoldKey,
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            Container(
              padding: EdgeInsets.all(defaultPadding),
              constraints: BoxConstraints(maxWidth: kMaxWidth),
              child: SafeArea(
                child: HomeScreen(),
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
