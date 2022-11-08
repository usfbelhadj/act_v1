import 'dart:io';
import 'package:actuaryadmin/controllers/controller.dart';
import 'package:actuaryadmin/screens/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:actuaryadmin/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants.dart';
import '../../responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Controller _controller;
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<bool> attemptLogIn(String username, String password) async {
    String credentials = "$username:$password";
    Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
    Map body = {
      "username": username,
      "password": password,
    };

    String encoded = stringToBase64Url.encode(credentials);

    var uri = Uri.parse("$SERVER_IP/api/auth");
    var res = await http.post(uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Basic $encoded',
          "content-type": "application/json",
        },
        body: json.encode(body));
    if (res.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final String token = "Bearer " + jsonDecode(res.body)['token'];
      print(token);
      await prefs.setString('token', "Bearer " + jsonDecode(res.body)['token']);

      _controller.token = token;
      _controller.getCurrentUser();

      return true;
    }
    return false;
  }

  @override
  void initState() {
    _controller = Get.find<Controller>(tag: "app_controller");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 200,
          minWidth: MediaQuery.of(context).size.width / 3,
          maxHeight: 200,
          maxWidth: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width / 3
              : MediaQuery.of(context).size.width / 2,
        ),
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: <Widget>[
              Text(
                "Admin login",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              TextButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    final bool succesLogin =
                        await attemptLogIn(username, password);
                    if (succesLogin) {
                      Get.off(
                        const DashboardScreen(),
                      );
                    } else {
                      displayDialog(context, "An Error Occurred",
                          "No account was found matching that username and password");
                    }
                  },
                  child: Text("Log In")),
            ],
          ),
        ),
      ),
    ));
  }
}
