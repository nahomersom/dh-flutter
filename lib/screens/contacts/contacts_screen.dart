// import 'package:contacts_service/contacts_service.dart';
import 'package:dh_flutter_v2/bloc/auth_bloc/auth_bloc.dart';
import 'package:dh_flutter_v2/model/models.dart';
import 'package:dh_flutter_v2/routes/custom_page_route.dart';
import 'package:dh_flutter_v2/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List names = ["Tech", "Daniel", "Eden", "Natnael", "Natnael", "Natnael"];
  List<User> contacts = [];

  @override
  void initState() {
    super.initState();
    _getUsers();
    // requestContactsPermission();
  }

  Future<void> requestContactsPermission() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      await Permission.contacts.request();
    } else {
      _loadContacts();
    }
  }

  Future<void> _loadContacts() async {
    await requestContactsPermission(); // Request permissiona
    // Iterable<Contact> fetchedContacts = await ContactsService.getContacts();

    // setState(() {
    //   contacts = fetchedContacts.toList();
    // });
  }

  _getUsers() {
    BlocProvider.of<AuthBloc>(context).add(const GetAllUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.largeMargin,
              vertical: AppConstants.mediumMargin),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    // padding: const EdgeInsets.all(5),
                    // height: 50,
                    // width: 50,
                    // alignment: Alignment.center,
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: AppConstants.grey400),
                    //     borderRadius: BorderRadius.circular(15)),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppConstants.grey700,
                    ),
                  ),
                ),
                const CustomText(
                  title: "Contacts",
                  fontSize: AppConstants.xxLarge,
                  textColor: Colors.black,
                ),
                SvgPicture.asset(AppAssets.search,
                    height: 25,
                    colorFilter: const ColorFilter.mode(
                      AppConstants.iconColor,
                      BlendMode.srcATop,
                    )),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const CustomText(
            //       title: "Contacts",
            //       fontSize: AppConstants.xxxLarge,
            //       textColor: Colors.black,
            //     ),
            //     SvgPicture.asset(AppAssets.search,
            //         height: 30,
            //         colorFilter: const ColorFilter.mode(
            //           AppConstants.iconColor,
            //           BlendMode.srcATop,
            //         )),
            //   ],
            // ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, authState) {
                if (authState is GetAllUsersFailure) {
                  SnackBarWidget.showSnackBar(context, authState.errorMessage);
                }
              },
              builder: (context, authState) {
                if (authState is GetAllUsersSuccess) {
                  contacts = authState.users;
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                customPageRoute(MessageDetailSreen(
                                    reciverId: contacts[index].id,
                                    isGroup: false,
                                    groupId: null)));
                          },
                          child: contactsCard(context,
                              '${contacts[index].firstName} ${contacts[index].middleName} ${contacts[index].lastName}'),
                        );
                      }),
                );
              },
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 40, 219, 106),
        onPressed: () {
          _showDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            height: 230,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.push(context,
                    //     customPageRoute(const AddExternalContactScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.grey300),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.people,
                              height: 30,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const CustomText(
                              title: "External Contact",
                              fontSize: AppConstants.large,
                              textColor: AppConstants.black,
                            )
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: AppConstants.black,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppConstants.grey300),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.newContact,
                            height: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const CustomText(
                            title: "New Contact",
                            fontSize: AppConstants.large,
                            textColor: AppConstants.black,
                          )
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppConstants.black,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Stack contactsCard(BuildContext context, String name) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
          margin: const EdgeInsets.only(top: 0, left: 2, right: 2, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: letterColors[name[0]],
                ),
                child: Text(
                  name.substring(0, 1),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AppConstants.large),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: AppConstants.medium,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Last seen recently",
                    style: TextStyle(
                        color: AppConstants.grey600,
                        fontSize: AppConstants.small),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
