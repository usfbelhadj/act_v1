import 'package:actuaryapp/constants.dart';
import 'package:actuaryapp/responsive.dart';
import 'package:actuaryapp/static/components/personnel_card.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  "assets/images/team2.jpg",
  "assets/images/team1.jpg",
  "assets/images/team3.png",
  "assets/images/team4.jpg",
];
final List<String> nameList = [
  "Rassem KETATA",
  "Yazid SELLAOUTI",
  "Mohamed Najed KSOURI",
  "Mehdi BEN YOUSSEF",
];
final List<String> titleList = [
  "PRÉSIDENT",
  "TRÉSORIER",
  "SECRÉTAIRE GÉNÉRAL",
  "VICE-PRÉSIDENT",
];

final List<Widget> cardsList = imgList
    .map(
      (item) => PersonnelCard(
        item,
        nameList[imgList.indexOf(item)],
        titleList[imgList.indexOf(item)],
      ),
    )
    .toList();

class TeamSection extends StatelessWidget {
  const TeamSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text(
              "Le Bureau Exécutif De L'ATA",
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
          if (Responsive.isDesktop(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: cardsList,
            ),
          if (!Responsive.isDesktop(context))
            Column(
              children: cardsList,
            ),
        ],
      ),
    );
  }
}
