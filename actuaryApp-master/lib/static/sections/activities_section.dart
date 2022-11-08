import 'package:actuaryapp/constants.dart';
import 'package:actuaryapp/responsive.dart';
import 'package:actuaryapp/static/components/image_slider.dart';
import 'package:flutter/material.dart';

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(
              "Activités De L'ATA",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: defaultPadding * 2,
          ),
          Container(
            height: (Responsive.isDesktop(context)) ? 500 : 300,
            child: ImageSlider(),
          ),
        ],
      ),
    );
  }
}
