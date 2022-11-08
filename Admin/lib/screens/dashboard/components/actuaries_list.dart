import 'package:actuaryadmin/controllers/controller.dart';
import 'package:actuaryadmin/models/Actuary.dart';
import 'package:actuaryadmin/screens/dashboard/components/drop_down_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../constants.dart';

class ActuariesList extends StatefulWidget {
  const ActuariesList({
    Key? key,
  }) : super(key: key);

  @override
  _ActuariesListState createState() => _ActuariesListState();
}

class _ActuariesListState extends State<ActuariesList> {
  late List<Actuary> actuaryList;
  late Controller _controller;
  late bool _isFetchingUsers;
  late bool _isAnErrorOccuredWhenFetchingUsers;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  void _fetchUsers({bool showloadingCircle = true}) {
    _isFetchingUsers = true;
    if (_isFetchingUsers) setState(() {});

    _controller.getUsers().then((value) {
      setState(() {
        actuaryList = value;
        _isFetchingUsers = false;
      });
      ;
    }).onError((error, stackTrace) {
      setState(() {
        _isFetchingUsers = false;
        _isAnErrorOccuredWhenFetchingUsers = true;
      });
    });
  }

  @override
  void initState() {
    _isFetchingUsers = false;
    _isAnErrorOccuredWhenFetchingUsers = false;

    _controller = Get.find<Controller>(tag: 'app_controller');
    // START FETCHING USERS;
    _fetchUsers();

    super.initState();
  }

  Widget get _buildactuariesList {
    if (_isFetchingUsers) {
      return const Center(child: CircularProgressIndicator());
    } else if (_isAnErrorOccuredWhenFetchingUsers) {
      return const Center(
        child: Text("An error was occured when trying to fetch users"),
      );
    } else {
      if (actuaryList.isNotEmpty) {
        return DataTable(
          columnSpacing: defaultPadding,
          columns: [
            DataColumn(
              label: Text("Name"),
            ),
            DataColumn(
              label: Text("Last active"),
            ),
            DataColumn(
              label: Text("Points"),
            ),
            DataColumn(label: Text("More"))
          ],
          rows: List.generate(
            actuaryList.length,
            (index) => ActuaryDataRow(actuaryList[index], _controller.token),
          ),
        );
      } else {
        return const Center(
          child: Text("NO USERS HERE YET"),
        );
      }
    }
  }

  void _showError(error) {
    // flutter defined function
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        error,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    ));
  }

  void displayDialog(context) => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: ConstrainedBox(
            constraints: new BoxConstraints(
              minHeight: 200,
              minWidth: MediaQuery.of(context).size.width / 3,
              maxHeight: 320,
              maxWidth: MediaQuery.of(context).size.width / 3,
            ),
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                //borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Add Actuary",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(labelText: 'First name'),
                  ),
                  TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(labelText: 'Last name'),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  TextButton(
                      onPressed: () async {
                        var username = _usernameController.text;
                        var email = _emailController.text;
                        var firstName = _firstNameController.text;
                        var lastName = _lastNameController.text;
                        print('${username} ${email} ${firstName} ${lastName}');
                        _controller
                            .createUser(username, email, firstName, lastName)
                            .then(
                          (value) {
                            try {
                              if (!value) {
                                _showError("Failed to create user!");
                              }
                            } catch (e) {
                              _showError(e);
                            }
                            _fetchUsers(showloadingCircle: false);
                          },
                        );
                        Navigator.of(context).pop();
                      },
                      child: Text("Add")),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Actuaries",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextButton(
                  onPressed: () => displayDialog(context), child: Text("add")),
            ],
          ),
          _buildactuariesList
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
DataRow ActuaryDataRow(Actuary actuary, token) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.network(
              actuary.image.toString(),
              width: 40,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(actuary.username!),
            ),
          ],
        ),
      ),
      DataCell(Text(actuary.lastactive.toString())),
      DataCell(Text(actuary.score.toString())),
      DataCell(DropDownMenu(actuary))
    ],
  );
}
