import 'dart:convert';
import 'dart:io';

import 'package:dh_flutter_v2/constants/app_theme.dart';
import 'package:dh_flutter_v2/screens/settings/widgets/profile_bottom_sheet_content.dart';
import 'package:dh_flutter_v2/utils/helper.dart';
import 'package:dh_flutter_v2/widgets/shared_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController firstNameController =
      TextEditingController(text: 'John');
  final TextEditingController middleNameController =
      TextEditingController(text: 'Alexander');
  final TextEditingController lastNameController =
      TextEditingController(text: 'Fernandes');
  final TextEditingController emailController =
      TextEditingController(text: 'johnalex22@gmail.com');
  bool isLoading = false;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  final FaceDetector _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
          enableContours: true,
          enableLandmarks: true,
          performanceMode: FaceDetectorMode.accurate));

  String _errorMessage = ''; // Variable to store the error message
  Future<void> _saveData() async {
    try {
      setState(() {
        isLoading = true;
      });
      //save image
      if (_image != null) {
        final bytes = await _image!.readAsBytes();
        final base64String = base64Encode(bytes);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("profile-image", base64String);
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error saving image: $e');
      setState(() {
        isLoading = false;
      });
    }
    Navigator.of(context).pop();
    context.go("/workspace/profile");
  }

  late GoRouter _router;
  @override
  void initState() {
    _router = GoRouter.of(context);
    _router.routerDelegate.addListener(_onRouteChange);
    super.initState();
  }

  Future<void> _onRouteChange() async {
    if (!mounted) return; // Check if widget is still mounted
    if (_router.state?.path == 'edit-profile') {
      await getProfileImage(); // Call your method here
    }
  }

  //Retrieve image as File
  Future<void> getProfileImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final base64String = prefs.getString("profile-image");

      if (base64String == null) return null;

      // Decode base64 string to bytes
      final bytes = base64Decode(base64String);

      // Create temporary file
      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/profile_image.jpg');

      // Write bytes to file
      await tempFile.writeAsBytes(bytes);
      setState(() {
        _image = XFile(tempFile.path);
      });
    } catch (e) {
      print('Error retrieving image: $e');
    }
  }

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
          _image = pickedFile;
          _errorMessage =
              "The picture you provided doesn't meet our requirements. Please ensure it's an authenticated ID photo and try again.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: AppTheme.gray.shade600,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Picture Container
            InkWell(
              onTap: _pickImage,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: _errorMessage.isNotEmpty
                      ? DecorationImage(
                          image: FileImage(
                            File(_image!.path),
                          ),
                          fit: BoxFit
                              .cover, // Ensure the image is contained without cropping
                        )
                      : null,
                  color:
                      _errorMessage.isNotEmpty ? null : AppTheme.info.shade600,
                ),
                child: _errorMessage.isNotEmpty || _image == null
                    ? const Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.white,
                        size: 20,
                      )
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

            const SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.error.shade100, // Light background color
                      shape: BoxShape.circle, // Circular shape
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.error.shade300
                              .withOpacity(0.1), // Shadow color
                          blurRadius: 8, // Blur intensity
                          offset: Offset(0, 4), // Shadow position
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8), // Padding inside the circle
                    child: Icon(
                      Icons.error_outline,
                      color: AppTheme.error.shade800, // Icon color
                      size: 32, // Icon size
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.error.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            const SizedBox(height: 16),
            // Form Fields
            SharedTextFormField(
              controller: firstNameController,
              label: 'First name',
              hintText: 'First name',
            ),
            const SizedBox(height: 16),
            SharedTextFormField(
              controller: middleNameController,
              label: 'Middle name',
              hintText: 'Middle name',
            ),
            const SizedBox(height: 16),
            SharedTextFormField(
              controller: lastNameController,
              label: 'Last name',
              hintText: 'Last name',
            ),
            const SizedBox(height: 16),
            SharedTextFormField(
              controller: emailController,
              label: 'Email (optional)',
              hintText: 'Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                // Regex for email validation
                final emailRegex = RegExp(
                  r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                );
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),

            const SizedBox(height: 62),
            // Buttons
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _errorMessage.isNotEmpty
                    ? null
                    : () {
                        showConfirmationDialog(
                            context: context,
                            title: "Are you sure you want to make changes?",
                            content: "Changes applied cannot be recovered.",
                            onConfirm: _saveData);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Confirm Changes',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.baseWhite),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppTheme.primary.shade600),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: AppTheme.primary.shade600,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _faceDetector.close();
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
