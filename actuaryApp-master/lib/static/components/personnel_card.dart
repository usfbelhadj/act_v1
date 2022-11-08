import 'package:actuaryapp/constants.dart';
import 'package:actuaryapp/responsive.dart';
import 'package:flutter/material.dart';

class PersonnelCard extends StatelessWidget {
  final String name;
  final String title;
  final String image;
  const PersonnelCard(
    this.image,
    this.name,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Text(
            title,
            style: TextStyle(color: kPrimaryColor),
          ),
          if (!Responsive.isDesktop(context))
            SizedBox(
              height: defaultPadding,
            ),
        ],
      ),
    );
  }
}
