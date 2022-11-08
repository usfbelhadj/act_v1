import 'dart:io';
import 'package:actuaryapp/responsive.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../main.dart';
import '../../controller.dart';
import '../dashboard/dashboard_screen.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = Get.find<Controller>(tag: "app_controller");
  }

  Future<bool> attemptLogIn(String username, String password) async {
    String credentials = "$username:$password";
    Map boddy = {
      "username": username,
      "password": password,
    };
    Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);

    String encoded = stringToBase64Url.encode(credentials);

    var uri = Uri.parse("$SERVER_IP/api/auth");
    var res = await http.post(uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Basic $encoded',
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(boddy));

    if (res.statusCode == 200) {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = "Bearer " + jsonDecode(res.body)['token'];

      await prefs.setString('token', token);
      _controller.token = token;
      _controller.refresh();

      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 200,
          minWidth: MediaQuery.of(context).size.width / 3,
          maxHeight: 300,
          maxWidth: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width / 3
              : MediaQuery.of(context).size.width / 2,
        ),
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: kDarkBlackColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: <Widget>[
              Text(
                "login",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.red),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  autofocus: true,
                  focusNode: FocusNode(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.red),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              ElevatedButton(
                  onPressed: () async {
                    UsersBinding().dependencies();
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    var jwt = await attemptLogIn(username, password);
                    if (jwt != false) {
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(),
                        ),
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
