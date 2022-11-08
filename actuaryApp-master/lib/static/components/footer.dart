import 'package:actuaryapp/constants.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDarkBlackColor,
      height: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(
              "Logo",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                    SizedBox(width: defaultPadding,),
                    Text(
                      "(+216) 53 255 666",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                    SizedBox(width: defaultPadding,),
                    Text(
                      "contact@actuaries.tn",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                    SizedBox(width: defaultPadding,),
                    Text(
                      "21 Rue Garibaldi Tunis 1001, Tunisie",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
