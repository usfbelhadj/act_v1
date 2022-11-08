import 'package:actuaryapp/constants.dart';
import 'package:actuaryapp/dashboard/dashboard_footer.dart';
import 'package:actuaryapp/dashboard/dashboard_header.dart';
import 'package:actuaryapp/dashboard/screens/dashboard/components/courses_list.dart';
import 'package:actuaryapp/dashboard/screens/dashboard/components/profile_card.dart';
import 'package:actuaryapp/responsive.dart';
import 'package:flutter/material.dart';

class DashboardMain extends StatefulWidget {
  @override
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height - 50,
          child: Column(
            children: [
              DashboardHeader("Dashboard"),
              Responsive.isDesktop(context)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: defaultPadding, left: defaultPadding),
                          child: Text(
                            "Course overview",
                            style:
                                TextStyle(fontSize: 20, color: kDarkBlackColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CoursesList(),
                                flex: 4,
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Expanded(
                                flex: 2,
                                child: ProfileCard(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          ProfileCard(),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          CoursesList(),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        if (Responsive.isDesktop(context)) DashboardFooter(),
      ],
    );
  }
}
