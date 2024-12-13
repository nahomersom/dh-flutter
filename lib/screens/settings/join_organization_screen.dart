import 'package:dh_flutter_v2/bloc/organization/organization_bloc.dart';
import 'package:dh_flutter_v2/model/models.dart';
import 'package:dh_flutter_v2/repository/repositories.dart';
import 'package:dh_flutter_v2/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class JoinOrganizationScreen extends StatefulWidget {
  const JoinOrganizationScreen({super.key});

  @override
  State<JoinOrganizationScreen> createState() => _JoinOrganizationScreenState();
}

class _JoinOrganizationScreenState extends State<JoinOrganizationScreen> {
  List<Organization> organizations = [];
  String searchString = "";
  User? user;
  int? orgId;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  _sendRequest(int orgId) {
    BlocProvider.of<OrganizationBloc>(context).add(CreateOrgInviteEvent(orgId));
  }

  Future<void> _askLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // Permission granted, proceed with your app logic
    } else if (status.isDenied) {
      // Permission denied, show a message to the user
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, direct the user to the app settings
      await openAppSettings();
    }
  }

  Future<void> _askPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus microphoneStatus = await Permission.microphone.request();

    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      // Permissions granted, proceed with your app logic
    } else if (cameraStatus.isDenied || microphoneStatus.isDenied) {
      // Permission denied, show a message to the user
    } else if (cameraStatus.isPermanentlyDenied ||
        microphoneStatus.isPermanentlyDenied) {
      // Permission permanently denied, direct the user to the app settings
      await openAppSettings();
    }
  }

  _loadProfile() async {
    var auth = AuthRepository();
    var token = await auth.getToken();
    logger("$token", {});
    await auth
        .getUserData()
        .then((value) => {user = value, orgId = int.parse(user!.orgId!)});
  }

  _searchOrg(String value) {
    BlocProvider.of<OrganizationBloc>(context)
        .add(SearchOrganizationEvent(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin:
              const EdgeInsets.symmetric(vertical: AppConstants.mediumMargin),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppConstants.largeMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        // height: 45,
                        // width: 45,
                        // alignment: Alignment.center,
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: AppConstants.grey400),
                        // borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppConstants.grey600,
                    )),
                  ),
                  const CustomText(
                    title: "Join Organization",
                    fontSize: AppConstants.xLarge,
                    textColor: AppConstants.black,
                  ),
                  Container(
                    width: 30,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    onChanged: (value) {
                      _searchOrg(value);
                      searchString = value;
                    },
                    onEditingComplete: () {
                      _searchOrg(searchString);
                    },
                    onTapOutside: (val) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset(AppAssets.search,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              AppConstants.iconColor,
                              BlendMode.srcATop,
                            )),
                      ),
                      hintText: "Search Organization",
                      hintStyle: const TextStyle(
                        color: AppConstants.grey400,
                        fontWeight: FontWeight.normal,
                        fontSize: AppConstants.large,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: AppConstants.grey300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: AppConstants.primaryColor),
                      ),
                    ),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.largeMargin,
                  vertical: AppConstants.mediumMargin),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const QRViewExample(),
                      ));
                      // _askPermissions();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.qr,
                              height: 15,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const CustomText(
                              title: "Scan QR Code",
                              fontSize: AppConstants.large,
                              textColor: AppConstants.black,
                            )
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppConstants.black,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider()
                ],
              ),
            ),
            BlocConsumer<OrganizationBloc, OrganizationState>(
              listener: (context, state) {
                if (state is SearchOrganizationFailure) {
                  SnackBarWidget.showSnackBar(context, state.errorMessage);
                }
                if (state is CreateOrgInviteFailure) {
                  SnackBarWidget.showSnackBar(context, state.errorMessage);
                }
                if (state is CreateOrgInviteSuccess) {
                  SnackBarWidget.showSuccessSnackBar(context,
                      "Invitation request to join has been sent successfully.");
                }
                if (state is SearchOrganizationSuccess) {
                  organizations = [];
                  for (Organization org in state.organizations) {
                    if (org.ownerId != user!.id!) {
                      if (!organizations.contains(org)) {
                        organizations.add(org);
                      }
                    }
                  }
                  // organizations = state.organizations;
                }
                setState(() {});
              },
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: organizations.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 10),
                          margin: const EdgeInsets.only(
                              top: 0, left: 20, right: 20, bottom: 10),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppConstants.primaryColor,
                                    ),
                                    child: Text(
                                      organizations[index]
                                          .name!
                                          .substring(0, 1)
                                          .toUpperCase(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 10,
                                      ),
                                      Text(
                                        toCamelCase(
                                            '${organizations[index].name} '),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: AppConstants.medium,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Text(
                                      //   "User ID: ${users[index].id}",
                                      //   style: const TextStyle(
                                      //       color: AppConstants
                                      //           .grey600,
                                      //       fontSize:
                                      //           AppConstants.small),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  _sendRequest(organizations[index].id!);
                                  // _sendRequest(users[index].id!);
                                },
                                icon: const Icon(Icons.add_circle),
                                color: AppConstants.primaryColor,
                              )
                            ],
                          ),
                        );
                      }),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      // body: QRCodeDartScanView(
      //   scanInvertedQRCode:
      //       true, // enable scan invert qr code ( default = false)

      //   typeScan: TypeScan
      //       .live, // if TypeScan.takePicture will try decode when click to take a picture(default TypeScan.live)
      //   // intervalScan: const Duration(seconds:1)
      //   // onResultInterceptor: (old,new){
      //   //  do any rule to controll onCapture.
      //   // }
      //   // takePictureButtonBuilder: (context, controller, isLoading) {
      //   // if typeScan == TypeScan.takePicture you can customize the button.
      //   //  if(loading) return CircularProgressIndicator();
      //   //   return ElevatedButton(
      //   //     onPressed: controller.takePictureAndDecode,
      //   //     child: Text('Take a picture'),
      //   //   );
      //   // },
      //   // resolutionPreset: = QrCodeDartScanResolutionPreset.high,
      //   // formats: [ // You can restrict specific formats.
      //   //  BarcodeFormat.qrCode,
      //   //  BarcodeFormat.aztec,
      //   //  BarcodeFormat.dataMatrix,
      //   //  BarcodeFormat.pdf417,
      //   //  BarcodeFormat.code39,
      //   //  BarcodeFormat.code93,
      //   //  BarcodeFormat.code128,
      //   //  BarcodeFormat.ean8,
      //   //  BarcodeFormat.ean13,
      //   // ],
      //   onCapture: (Result result) {
      //     // do anything with result
      //     result.text;
      //     print("#################################${result.text}");
      //     Navigator.pop(context);
      //     // result.rawBytes
      //     // result.resultPoints
      //     // result.format
      //     // result.numBits
      //     // result.resultMetadata
      //     // result.time
      //   },
      // ),
    );
  }
}
