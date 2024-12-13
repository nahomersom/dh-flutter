import 'package:dh_flutter_v2/constants/constants.dart';
import 'package:dh_flutter_v2/model/models.dart';
import 'package:dh_flutter_v2/repository/repositories.dart';
import 'package:dh_flutter_v2/utils/utils.dart';
import 'package:dh_flutter_v2/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/groups/groups_bloc.dart';

class AddListScreen extends StatefulWidget {
  const AddListScreen({super.key});

  @override
  _AddListScreenState createState() => _AddListScreenState();
}

class _AddListScreenState extends State<AddListScreen> {
  final TextEditingController _listNameController = TextEditingController();
  Color _selectedColor = Colors.blue;
  User? user;
  int? orgId;
  final List<Color> _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.lightBlue,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];
  @override
  void initState() {
    _loadProfile();
    super.initState();
  }

  _loadProfile() async {
    var auth = AuthRepository();
    var token = await auth.getToken();
    logger("$token", {});
    await auth.getUserData().then((value) => {
          user = value,
          if (user!.orgId != null)
            {
              orgId = int.parse(user!.orgId!),
              _getOrgGroups(int.parse(user!.orgId!))
            }
        });
  }

  _getOrgGroups(int orgId) {
    BlocProvider.of<GroupsBloc>(context)
        .add(GetOrganizationGroups(orgId: orgId));
  }

  _getMyGroups() {
    BlocProvider.of<GroupsBloc>(context).add(GetMyGroups());
  }

  _getMyPersonalGroups() {
    BlocProvider.of<GroupsBloc>(context).add(GetMyPersonalGroups());
  }

  _createGroup(int? orgId, String name, String color) {
    BlocProvider.of<GroupsBloc>(context)
        .add(CreateGroup(orgId: orgId, name: name, color: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.large)),
                  ),
                  BlocConsumer<GroupsBloc, GroupsState>(
                    listener: (context, groupState) {
                      if (groupState is CreateGroupError) {
                        SnackBarWidget.showSnackBar(
                            context, groupState.errorMessage);
                      }
                      if (groupState is CreateGroupSuccess) {
                        Navigator.pop(context);
                        SnackBarWidget.showSuccessSnackBar(
                            context, "Group created successfully");
                        _getMyGroups();
                        _getMyPersonalGroups();
                        _getOrgGroups(orgId!);
                      }
                    },
                    builder: (context, groupState) {
                      if (groupState is CreateGroupLoading) {
                        return Container(
                            padding: const EdgeInsets.only(right: 5),
                            height: 20,
                            width: 25,
                            child: const CircularProgressIndicator());
                      }
                      return TextButton(
                        onPressed: () {
                          if (_listNameController.text != "") {
                            _createGroup(orgId, _listNameController.text,
                                _selectedColor.toString());
                          } else {
                            FocusScope.of(context).unfocus();

                            SnackBarWidget.showSnackBar(
                                context, "Please enter group name");
                          }
                        },
                        child: const Text('Save',
                            style: TextStyle(
                                color: AppConstants.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstants.large)),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                  decoration: BoxDecoration(
                      color: AppConstants.grey300,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      // Displaying the selected color
                      CircleAvatar(
                        backgroundColor: _selectedColor,
                        radius: 50,
                        child: Text(
                          _listNameController.text == "" ||
                                  _listNameController.text.length < 2
                              ? 'DH'
                              : _listNameController.text
                                  .substring(0, 2)
                                  .toUpperCase(), // Replace with your custom text or widget
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.xxxxLarge,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Color Picker Grid
                      // Text field for list name
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppConstants.mediumMargin,
                            vertical: 10),
                        child: TextField(
                          controller: _listNameController,
                          decoration: InputDecoration(
                              hintText: 'New List',
                              hintStyle: const TextStyle(
                                  color: AppConstants.grey200,
                                  fontSize: AppConstants.xLarge),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(11)),
                              filled: true,
                              fillColor: AppConstants.grey400),
                          onChanged: (va) {
                            setState(() {});
                          },
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: AppConstants.xLarge,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.white),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  )),
              const SizedBox(height: 26),
              Container(
                height: 150,
                padding: const EdgeInsets.all(AppConstants.mediumMargin),
                decoration: BoxDecoration(
                    color: AppConstants.grey300,
                    borderRadius: BorderRadius.circular(12)),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, // Number of colors per row
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: _colors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = _colors[index];
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: _colors[index],
                        child: _selectedColor == _colors[index]
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
