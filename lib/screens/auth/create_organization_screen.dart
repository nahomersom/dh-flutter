import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dh_flutter_v2/bloc/auth_bloc/auth_bloc.dart';
import 'package:dh_flutter_v2/routes/custom_page_route.dart';
import 'package:dh_flutter_v2/screens/root/root_screen.dart';
import 'package:dh_flutter_v2/utils/utils.dart';
import 'package:dh_flutter_v2/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../constants/constants.dart';
import '../../widgets/widgets.dart';

class CreateOrganizationScreen extends StatefulWidget {
  const CreateOrganizationScreen({super.key});

  @override
  State<CreateOrganizationScreen> createState() =>
      _CreateOrganizationScreenState();
}

class _CreateOrganizationScreenState extends State<CreateOrganizationScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _middleNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();

  File? profileImage;

  final _formKey = GlobalKey<FormState>();
  bool isSubmitted = false;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the widget is disposed
    _firstNameFocusNode.dispose();
    _middleNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  // Future _pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);

  //     if (image != null) {
  //       final imageFile = File(image.path);

  //       final appDir = await getApplicationDocumentsDirectory();
  //       final targetPath = '${appDir.path}/profile-${DateTime.now()}.jpg';

  //       XFile compressedFile = await compressAndGetFile(imageFile, targetPath);
  //       return File(compressedFile.path);
  //     }
  //   } catch (e) {
  //     //
  //   }
  // }

  Future<int> firebaseML(File file) async {
    InputImage? inputImage;
    inputImage = InputImage.fromFile(file);
    final options = FaceDetectorOptions();
    final faceDetector = FaceDetector(options: options);
    final List<Face> faces = await faceDetector.processImage(inputImage);
    return faces.length;
  }

  Future _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      final appDir = await getApplicationDocumentsDirectory();
      final targetPath = '${appDir.path}/profile-${DateTime.now()}.jpg';
      XFile compressedFile = await compressAndGetFile(imageFile, targetPath);
      File newCompressedFile = File(compressedFile.path);
      int length = await firebaseML(newCompressedFile);
      if (length > 0) {
        return newCompressedFile;
      } else {
        setState(() {
          userData["profileSize"] = null;
          profileImage = null;
        });
        SnackBarWidget.showSnackBar(
            context, "Please upload a valid photo showing your genuine face");
        return null;
      }
    }
  }

  _completeProfile() {
    BlocProvider.of<AuthBloc>(context).add(CompleteProfileEvent(
        firstName.text, middleName.text, lastName.text, profileImage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.largeMargin,
              vertical: AppConstants.mediumMargin),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width * 0.4,
              //       child: LinearPercentIndicator(
              //         alignment: MainAxisAlignment.start,
              //         animation: false,
              //         lineHeight: 6.0,
              //         animationDuration: 2500,
              //         percent: 0.4,
              //         progressColor: Colors.green,
              //         barRadius: const Radius.circular(3),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppConstants.grey700,
                    ),
                  ),
                  const CustomText(
                    title: "Sign Up",
                    textColor: AppConstants.primaryColor,
                    fontSize: AppConstants.xxLarge,
                  ),
                  Container(
                    width: 15,
                  )
                ],
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  autovalidateMode: isSubmitted
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const CustomText(
                        title: "Create your Profile",
                        textColor: AppConstants.black,
                        fontSize: AppConstants.xxxLarge,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur",
                        style: TextStyle(
                          color: AppConstants.grey600,
                          fontSize: AppConstants.medium,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const CustomText(
                        title: "Your profile",
                        textColor: AppConstants.black,
                        fontSize: AppConstants.xxLarge,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              File image = await _pickImage();
                              setState(() {
                                profileImage = image;
                              });
                              logger("$image", {});
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  padding: const EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                    color: AppConstants.primaryColorVeryLight,
                                    borderRadius: BorderRadius.circular(15),
                                    image: profileImage != null
                                        ? DecorationImage(
                                            image: FileImage(profileImage!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  child: profileImage == null
                                      ? Image.asset(AppAssets.user)
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                      height: 34,
                                      width: 34,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                          shape: BoxShape.circle,
                                          color: AppConstants.primaryColor),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 20,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                          isRequired: false,
                          hintText: "David",
                          focusNode: _firstNameFocusNode,
                          controller: firstName,
                          name: "First name",
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(_middleNameFocusNode);
                          },
                          validator: (val) => InputValidator()
                              .isFullNameValid(val!, "first name")),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          isRequired: false,
                          focusNode: _middleNameFocusNode,
                          hintText: "John",
                          controller: middleName,
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(_lastNameFocusNode);
                          },
                          name: "Middle name",
                          validator: (value) => InputValidator()
                              .isFullNameValid(value!, "middle name")),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                          isRequired: false,
                          focusNode: _lastNameFocusNode,
                          hintText: "Peterson",
                          controller: lastName,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              isSubmitted = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              _completeProfile();
                            }
                          },
                          name: "Last name",
                          validator: (value) => InputValidator()
                              .isFullNameValid(value!, "last name")),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // const Text(
                      //   "Job title",
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.normal,
                      //     color: AppConstants.grey500,
                      //   ),
                      // ),
                      // selectJob(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is CompleteProfileFailure) {
                            SnackBarWidget.showSnackBar(
                                context, state.errorMessage);
                          }

                          if (state is CompleteProfileSuccess) {
                            Navigator.push(
                                context, customPageRoute(const RootScreen()));
                          }
                        },
                        builder: (context, state) {
                          if (state is CompleteProfileLoading) {
                            return CustomButton(
                                backgroundColor: AppConstants.grey500,
                                isLoading: true,
                                loadingText: "Processing...",
                                onPressed: () {},
                                title: "");
                          }
                          return CustomButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  isSubmitted = true;
                                });
                                if (_formKey.currentState!.validate()) {
                                  _completeProfile();
                                }
                              },
                              title: "Confirm");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomDropdown selectJob() {
    return CustomDropdown<String>(
      onChanged: (value) {},
      hintText: "Select",
      decoration: CustomDropdownDecoration(
          closedBorder: Border.all(color: AppConstants.grey300),
          closedFillColor: AppConstants.backgroundColor,
          hintStyle: const TextStyle(
            color: AppConstants.grey700,
            fontWeight: FontWeight.normal,
            fontSize: AppConstants.medium,
          ),
          closedSuffixIcon: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: AppConstants.primaryColorVeryLight,
                borderRadius: BorderRadius.circular(5)),
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: AppConstants.grey600,
            ),
          ),
          errorStyle: TextStyle(
            color: Colors.red.shade800,
            fontWeight: FontWeight.normal,
            fontSize: AppConstants.small,
          ),
          closedErrorBorder: Border.all(color: Colors.red)),
      items: const ["", ""],
    );
  }
}
