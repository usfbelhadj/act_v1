import 'package:actuaryadmin/controllers/controller.dart';
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

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = Get.find<Controller>(tag: 'app_controller');

    final currentUser = _controller.currentUser;

    setState(() {
      _usernameController.text = currentUser.username;
      _firstNameController.text = currentUser.firstName;
      _lastNameController.text = currentUser.lastName;
      _emailController.text = currentUser.email;
      _phoneController.text = currentUser.phone;
    });
  }

  void displayDialog(context, response) => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(),
              child: response == true
                  ? Text("Profile updated!")
                  : Text("Failed to update profile!")),
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
                "Profile",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              EditField(
                controller: _usernameController,
                labelText: 'Username',
              ),
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
                    var username = _usernameController.text;
                    var email = _emailController.text;
                    var firstName = _firstNameController.text;
                    var lastName = _lastNameController.text;
                    var phone = _phoneController.text;
                    _controller
                        .updateProfile(
                            username, email, firstName, lastName, phone)
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
