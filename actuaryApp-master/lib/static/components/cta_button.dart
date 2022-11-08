import 'package:actuaryapp/dashboard/screens/login/login_screen.dart';
import 'package:actuaryapp/responsive.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CTA extends StatelessWidget {
  const CTA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5,
              vertical:
                  defaultPadding / (Responsive.isDesktop(context) ? 1 : 2),
            ),
          ),
          child: Text("Login"),
        ),
      ],
    );
  }
}
