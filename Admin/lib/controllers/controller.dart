import 'dart:convert';

import 'package:actuaryadmin/models/Actuary.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class Controller extends GetxController {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var token;
  var currentuser;

  String get getToken => token;
  get currentUser => currentuser;

  @override
  void onInit() async {
    await _prefs.then((SharedPreferences prefs) {
      token = prefs.getString('token');
      print(token);
    }).whenComplete(await () {
      getCurrentUser().then((value) {
        currentuser = value;
      }).whenComplete(() => update());
    });
    super.onInit();
  }

  Future<Actuary> getCurrentUser() async {
    Actuary actuary = new Actuary();

    var responce = await http.get(
      Uri.parse("$SERVER_IP/api/user/current"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token'
      },
    );

    var user = actuary.fromJson(jsonDecode(responce.body));

    return user;
  }

  Future<bool> updateProfile(
      username, email, firstName, lastName, phone) async {
    // ignore: unused_local_variable
    print("update $firstName $lastName $email $phone");
    var responce = await http.patch(
      Uri.parse("$SERVER_IP/api/user/current"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token'
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'email': email,
          'firstname': firstName,
          'lastname': lastName,
          'phone1': phone,
        },
      ),
    );
    print(responce.body);
    if (responce.statusCode == 200) {
      getCurrentUser().then((value) {
        print(value);
        currentuser = value;
      });
      return true;
    }
    return false;
  }

  Future<bool> changePassword(oldPassword, newPassword, confirmPassword) async {
    var responce = await http.put(
      Uri.parse("$SERVER_IP/api/user/current"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token'
      },
      body: jsonEncode(
        <String, String>{
          'oldPassword': oldPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
      ),
    );
    if (responce.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<Actuary>> getUsers() async {
    List<Actuary> list = [];
    Actuary actuary = new Actuary();
    var responce = await http.get(
      Uri.parse("$SERVER_IP/api/user"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token'
      },
    );

    for (var user in jsonDecode(responce.body)["users"]) {
      list.add(actuary.fromJson(user));
    }

    return list;
  }

  Future<bool> createUser(username, email, firstName, lastName) async {
    var responce = await http.post(
      Uri.parse("$SERVER_IP/api/user"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token'
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
        },
      ),
    );
    if (responce.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<bool> deleteUser(publicID) async {
    var responce = await http.delete(
      Uri.parse("$SERVER_IP/api/users/$publicID"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token'
      },
    );
    print(responce.body);
    if (responce.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<bool> enrolUser(publicID, courseID) async {
    var responce = await http.post(
      Uri.parse("$SERVER_IP/api/courses"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token'
      },
      body: jsonEncode(
        <String, String>{
          'publicID': publicID,
          'courseID': courseID,
        },
      ),
    );
    if (responce.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<Map> coursesList() async {
    var responce = await http.get(
      Uri.parse("$SERVER_IP/api/courses/list"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token'
      },
    );

    return jsonDecode(responce.body);
  }
}
