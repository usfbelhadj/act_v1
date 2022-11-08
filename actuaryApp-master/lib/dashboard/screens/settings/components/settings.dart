import 'package:actuaryapp/dashboard/dashboard_footer.dart';
import 'package:actuaryapp/dashboard/dashboard_header.dart';
import 'package:actuaryapp/dashboard/editTextWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../controller.dart';

class Settings extends StatefulWidget {
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Controller _controller = Get.find<Controller>(tag: 'app_controller');

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void displayDialog(context, response) => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: kDarkBlackColor,
              ),
              child: response == true
                  ? Text("Password Changed!")
                  : Text("Failed to change password!")),
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
              DashboardHeader("Settings"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: defaultPadding, left: defaultPadding),
                    child: Text(
                      "Change password",
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
                            controller: _oldPasswordController,
                            labelText: 'Current Password',
                          ),
                          EditField(
                            controller: _newPasswordController,
                            labelText: 'New Password',
                            obscureText: true,
                          ),
                          EditField(
                            controller: _confirmPasswordController,
                            labelText: 'Confirm Password',
                            obscureText: true,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                var oldPassword = _oldPasswordController.text;
                                var newPassword = _newPasswordController.text;
                                var confirmPassword =
                                    _confirmPasswordController.text;
                                _controller
                                    .changePassword(oldPassword, newPassword,
                                        confirmPassword)
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
