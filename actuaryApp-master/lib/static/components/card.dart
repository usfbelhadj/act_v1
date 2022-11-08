import 'package:actuaryapp/constants.dart';
import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  const TextCard(this.title, this.description, this.icon);
  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: (width >= 1390 || width < 900) ? 350 : (width - 300) / 3,
      constraints: BoxConstraints(
        minHeight: 350,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30),
            child: Icon(
              icon,
              size: 50,
              color: kPrimaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Raleway',
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: kDarkBlackColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Color(0x33303030),
            offset: Offset(0, 5),
            blurRadius: 15,
            spreadRadius: 0,
          ),
        ],
      ),
    );
  }
}
