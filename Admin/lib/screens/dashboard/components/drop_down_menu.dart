import 'package:actuaryadmin/controllers/controller.dart';
import 'package:actuaryadmin/models/Actuary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;

// ignore: must_be_immutable
Map map = {
  "33": "Initiation to Python Programming for Mathematics",
  "43": "Data Streaming",
  "63": "Dauphine Admission Test - June 2022",
  "45": "Big Data on the Cloud",
  "44": "No SQL and New SQL",
  "40": "Big Data Architecture",
  "34": "Scala",
  "37": "Statistics Fundamentals",
  "35": "Bash",
  "38": "Python 3: Fundamentals of procedural programming",
  "58": "Python 3: Fundamentals of procedural programming ",
  "65": "Summer Camp Dauphine - Python 1 - Juillet 2022 - 2eme Quinzaine",
};

class DropDownMenu extends StatelessWidget {
  final Controller _controller = Get.put(Controller());
  Actuary actuary;
  DropDownMenu(this.actuary);
  void _showError(error, context) {
    // flutter defined function
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        error,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Text("delete"),
          onTap: () {
            _controller.deleteUser(actuary.publicID).then((value) {
              if (!value) {
                _showError("Failed to delete user!", context);
              }
              html.window.location.reload();
            });
          },
          value: 0,
        ),
        // PopupMenuItem(
        //   onTap: () {
        //     _controller.coursesList().then((value) {
        //       print("*********************");
        //       print(value["courses"]);
        //       for (var i in value["courses"]) {
        //         print(i["id"]);
        //         print(i["name"]);
        //       }
        //       print("*********************");
        //     });
        //     _controller.enrolUser(actuary.publicID, "75").then((value) {
        //       print(value);
        //       if (!value) {
        //         _showError("Failed!", context);
        //       }
        //       html.window.location.reload();
        //       print('ok');
        //     });
        //   },
        //   child: Text("enrol"),
        //   value: 1,
        // ),
        PopupMenuItem(
          onTap: () {
            _controller.enrolUser(actuary.publicID, "73").then((value) {
              if (!value) {
                _showError("Failed!", context);
              }
              html.window.location.reload();

              print('ok');
            });
          },
          child: PopupMenuButton(
            child: Text('Courses List'),
            onSelected: (result) {
              Navigator.pop(context);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                onTap: () {
                  _controller.enrolUser(actuary.publicID, "78").then((value) {
                    if (!value) {
                      _showError("Failed!", context);
                    }
                    html.window.location.reload();
                    print('ok');
                  });
                },
                child: Text("Scala"),
                value: 1,
              ),
              PopupMenuItem(
                onTap: () {
                  _controller.enrolUser(actuary.publicID, "77").then((value) {
                    if (!value) {
                      _showError("Failed!", context);
                    }
                    html.window.location.reload();
                    print('ok');
                  });
                },
                child: Text("SQL"),
                value: 2,
              ),
              PopupMenuItem(
                onTap: () {
                  _controller.enrolUser(actuary.publicID, "79").then((value) {
                    if (!value) {
                      _showError("Failed!", context);
                    }
                    html.window.location.reload();
                    print('ok');
                  });
                },
                child: Text("Python Programing"),
                value: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
