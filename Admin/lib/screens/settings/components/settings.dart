import 'package:actuaryadmin/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants.dart';
import '../../../editTextWidget.dart';

class Settings extends StatefulWidget {
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Controller _controller = Get.put(Controller());

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void displayDialog(context, response) => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              child: response == true
                  ? Text("Password Changed!")
                  : Text("Failed to change password!")),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: <Widget>[
              Text(
                "Settings",
                style: Theme.of(context).textTheme.subtitle1,
              ),
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
                    var confirmPassword = _confirmPasswordController.text;
                    _controller
                        .changePassword(
                            oldPassword, newPassword, confirmPassword)
                        .then((value) => displayDialog(context, value));
                  },
                  child: Text("Save")),
            ],
          ),
        ),
      ],
    );
  }
}
