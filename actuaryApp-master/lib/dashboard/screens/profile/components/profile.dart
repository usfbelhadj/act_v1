import 'package:actuaryapp/dashboard/controller.dart';
import 'package:actuaryapp/dashboard/dashboard_footer.dart';
import 'package:actuaryapp/dashboard/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../editTextWidget.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Controller _controller;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = Get.find<Controller>(tag: 'app_controller');

    var currentUser = _controller.currentUser;
    print(currentUser?.firstName);
    print(currentUser?.lastName);
    print(currentUser?.email);
    print(currentUser?.phone);

    if (currentUser != null) {
      setState(() {
        _firstNameController.text = currentUser.firstName ?? "";
        _lastNameController.text = currentUser.lastName ?? "";
        _emailController.text = currentUser.email ?? "";
        _phoneController.text = currentUser.phone ?? "";
      });
    }
  }

  void displayDialog(context, response) => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: kDarkBlackColor,
              ),
              child: response == true
                  ? Text("Profile updated!")
                  : Text("Failed to update profile!")),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height - 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardHeader("Profile"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: defaultPadding, left: defaultPadding),
                    child: Text(
                      "Edit profile",
                      style: TextStyle(fontSize: 20, color: kDarkBlackColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: kDarkBlackColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: <Widget>[
                          EditField(
                            controller: _firstNameController,
                            labelText: 'First Name',
                          ),
                          EditField(
                            controller: _lastNameController,
                            labelText: 'Last Name',
                          ),
                          EditField(
                            controller: _emailController,
                            labelText: 'email',
                          ),
                          EditField(
                            controller: _phoneController,
                            labelText: 'Phone Number',
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                var email = _emailController.text;
                                var firstName = _firstNameController.text;
                                var lastName = _lastNameController.text;
                                var phone = _phoneController.text;
                                await _controller
                                    .updateProfile(
                                        email, firstName, lastName, phone)
                                    .then((value) =>
                                        displayDialog(context, value));
                              },
                              child: Text("Save")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        DashboardFooter(),
      ],
    );
  }
}
