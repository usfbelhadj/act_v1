import 'package:actuaryapp/constants.dart';
import 'package:actuaryapp/responsive.dart';
import 'package:actuaryapp/static/components/card.dart';
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: defaultPadding,
          ),
          Container(
            child: Text(
              "A Propos De L'ATA",
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCard(
                  "Objectifs",
                  "L'association tunisienne des experts actuaires a pour objectif de garantir la compétence professionnelle et la crédibilité de ses membres ainsi que la contribution à assurer la qualité de la formation scientifique et professionnelle de ses participants.",
                  Icons.settings,
                ),
                SizedBox(
                  width: defaultPadding * 2,
                ),
                TextCard(
                  "Chiffres clés",
                  "Date de création : 9 Février 2017\nNombre d'adhérents : 18\nAssociations Partenaires : 3",
                  Icons.query_stats,
                ),
                SizedBox(
                  width: defaultPadding * 2,
                ),
                TextCard(
                  "Statut administratif",
                  "Type : Association scientifique\nDénomination sociale : Association Tunisienne des Experts Actuaires\nNuméro de dépôt au JORT : 2017400874APSF1",
                  Icons.sticky_note_2,
                ),
              ],
            ),
          if (!Responsive.isDesktop(context))
            Column(
              children: [
                TextCard(
                  "Objectifs",
                  "L'association tunisienne des experts actuaires a pour objectif de garantir la compétence professionnelle et la crédibilité de ses membres ainsi que la contribution à assurer la qualité de la formation scientifique et professionnelle de ses participants.",
                  Icons.settings,
                ),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                TextCard(
                  "Chiffres clés",
                  "Date de création : 9 Février 2017\nNombre d'adhérents : 18\nAssociations Partenaires : 3",
                  Icons.query_stats,
                ),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                TextCard(
                  "Statut administratif",
                  "Type : Association scientifique\nDénomination sociale : Association Tunisienne des Experts Actuaires\nNuméro de dépôt au JORT : 2017400874APSF1",
                  Icons.sticky_note_2,
                ),
              ],
            )
        ],
      ),
    );
  }
}
