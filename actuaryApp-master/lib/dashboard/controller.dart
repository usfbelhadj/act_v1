import 'dart:convert';
import 'package:actuaryapp/dashboard/models/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'models/Actuary.dart';

class Controller extends GetxController {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? token;

  late ValueNotifier<Actuary?> _currentuser;
  late ValueNotifier<List<Course>?> _courses;

  Actuary? get currentUser => _currentuser.value;
  ValueNotifier<Actuary?> get currentUserNotifier => _currentuser;

  set currentUser(Actuary? actuary) => _currentuser.value = actuary;
  List<Course>? get coursesList => _courses.value;
  ValueNotifier<List<Course>?> get coursesListNotifier => _courses;

  set coursesList(List<Course>? list) => _courses.value = list;

  @override
  void onInit() {
    _currentuser = ValueNotifier<Actuary?>(null);
    _courses = ValueNotifier<List<Course>?>(null);

    _prefs.then((SharedPreferences prefs) {
      token = prefs.getString('token');
    }).whenComplete(() async {
      if (token != null) {
        refresh();
      }
    });
    super.onInit();
  }

  Future<void> fetchCurrentUser() async {
    Actuary actuary = new Actuary();

    var responce = await http.get(
      Uri.parse("$SERVER_IP/api/user/current"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token'
      },
    );
    var data = jsonDecode(responce.body);
    if (data["msg"] == "Token has expired") {
      token = null;
      await onLogout();
      refresh();
    }

    var user = actuary.fromJson(jsonDecode(responce.body));

    print("FETCHED USER $user");

    _currentuser.value = user;
  }

  Future<bool> updateProfile(email, firstName, lastName, phone) async {
    // ignore: unused_local_variable
    var responce = await http.patch(
      Uri.parse("$SERVER_IP/api/user/current"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token'
      },
      body: jsonEncode(
        <String, String>{
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
        },
      ),
    );
    refresh();
    if (responce.statusCode == 200) {
      await fetchCurrentUser();
      refresh();
      return true;
    }
    return false;
  }

  Future<bool> changePassword(oldPassword, newPassword, confirmPassword) async {
    var responce = await http.post(
      Uri.parse("$SERVER_IP/change_password"),
      headers: {
        "x-access-token": token!,
        'content-type': 'application/json',
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

  void refresh() async {
    return await fetchCurrentUser().then((value) async => await getCourses());
  }

  Future<void> getCourses() async {
    List<Course> courses = [];
    Course course = new Course();
    var responce = await http.get(
      Uri.parse("$SERVER_IP/api/user/course"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$token'
      },
    );

    var data = jsonDecode(responce.body);

    try {
      for (var crs in data["Courses"]) {
        print(crs);
        courses.add(course.fromJson(crs));
      }
      _courses.value = courses;
    } catch (e) {
      _courses.value = [];
    }
  }

  Future<bool> onLogout() async {
    currentUser = null;
    token = null;
    coursesList = null;

    return await _prefs
        .then((SharedPreferences prefs) async {
          prefs.remove('token');
        })
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }
}
