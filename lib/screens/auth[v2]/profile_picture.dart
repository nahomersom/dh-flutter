import 'dart:io';

import 'package:dh/constants/app_assets.dart';
import 'package:dh/constants/app_constants.dart';
import 'package:dh/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureScreen extends StatefulWidget {
  @override
  _ProfilePictureScreenState createState() => _ProfilePictureScreenState();
}

class _ProfilePictureScreenState extends State<ProfilePictureScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  final FaceDetector _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
          enableContours: true,
          enableLandmarks: true,
          performanceMode: FaceDetectorMode.accurate));

  String _errorMessage = ''; // Variable to store the error message

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final inputImage = InputImage.fromFilePath(pickedFile.path);
      final faces = await _faceDetector.processImage(inputImage);

      if (faces.length == 1) {
        setState(() {
          _image = pickedFile;
          _errorMessage = ''; // Clear any previous error
        });
      } else {
        setState(() {
          _errorMessage = faces.length == 0
              ? "No face detected. Please upload an image with a single face."
              : "Multiple faces detected. Please upload an image with only one face.";
        });
      }
    }
  }

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.bodyPadding.copyWith(top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('skip',
                      textAlign: TextAlign.right,
                      style: AppConstants.bodySmallTextStyle.copyWith(
                          color: AppConstants.primaryAlternativeColor)),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    'Profile Picture',
                    style: AppConstants.largeTitleTextStyle
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    'Please add a formal ID picture so that we can identify you.',
                    style: AppConstants.bodyTextStyle
                        .copyWith(color: AppConstants.grey800),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  // Display error message if there's any
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 10),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  Center(
                    child: Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAssets.profileImage),
                          fit: BoxFit
                              .cover, // Ensure the image is contained without cropping
                        ),
                        color: const Color(0xffE3E3E3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(48)),
                      ),
                      child: _image == null
                          ? const SizedBox()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(48),
                              child: Image.file(
                                File(_image!.path),
                                fit: BoxFit
                                    .cover, // Ensure the uploaded image is contained without cropping
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ActionButton(
                    onPressed: _pickImage,
                    text: '+ Upload Photo',
                    isActionButton: false,
                  )
                ],
              ),
              ActionButton(
                onPressed: _image != null
                    ? () {
                        // Handle valid phone number submission
                      }
                    : null, // Disable button if invalid
                text: 'Continue',
                isActionButton: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
