import 'package:actuaryapp/dashboard/models/Actuary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../controller.dart';

class ProfileCard extends StatefulWidget {
  //@override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late Controller _controller;
  @override
  void initState() {
    _controller = Get.find<Controller>(tag: 'app_controller');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("ProfileCard builded");
    return ValueListenableBuilder(
      valueListenable: _controller.currentUserNotifier,
      builder: (BuildContext context, Actuary? currentUser, Widget? child) {
        return currentUser != null
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: kDarkBlackColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(currentUser.firstName ?? ""),
                        SizedBox(
                          width: defaultPadding / 2 - 3,
                        ),
                        Text(currentUser.lastName ?? ""),
                      ],
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Text("Points"),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Text(currentUser.score.toString()),
                    SizedBox(
                      height: defaultPadding,
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
