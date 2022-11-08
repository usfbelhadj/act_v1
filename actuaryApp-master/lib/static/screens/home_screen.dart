import 'package:actuaryapp/constants.dart';
import 'package:actuaryapp/static/sections/about_section.dart';
import 'package:actuaryapp/static/sections/activities_section.dart';
import 'package:actuaryapp/static/sections/team_section.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AboutSection(),
        SizedBox(
          height: defaultPadding * 2,
        ),
        Divider(),
        SizedBox(
          height: defaultPadding * 2,
        ),
        ActivitiesSection(),
        SizedBox(
          height: defaultPadding * 2,
        ),
        Divider(),
        SizedBox(
          height: defaultPadding * 2,
        ),
        TeamSection(),
        SizedBox(
          height: defaultPadding * 2,
        ),
      ],
    );
  }
}
