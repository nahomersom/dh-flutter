// import 'dart:io';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:emebet/widgets/widgets.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ntp/ntp.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path/path.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../constants/constants.dart';

import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  // Define the date format
  final DateFormat formatter = DateFormat(' MMMM, yyyy');

  // Format the date using the defined format
  String formattedDate = formatter.format(date);

  return formattedDate;
}

// String formatDate(String date) {
//   return DateFormat('MMM dd, yyyy').format(DateTime.parse(date));
// }

// String getKeysByValues(Map<String, String> map, String value) {
//   return map.keys
//       .firstWhere((element) => map[element] == value, orElse: () => "");
// }

// String isDateWithinRange(DateTime date) {
//   DateTime today = DateTime.now();
//   Duration difference = date.difference(today);
//   int daysDifference = difference.inDays;
//   if (daysDifference < 3) {
//     return "red";
//   } else if (daysDifference <= 5) {
//     return "yellow";
//   } else {
//     return "green";
//   }
// }

// String formatSalary(String salary, String time) {
//   if (double.tryParse(salary) != null) {
//     final formatCurrency = NumberFormat("#,##0", "en_US");
//     return '${formatCurrency.format(double.parse(salary))} ETB ${time.toLowerCase()}';
//   } else {
//     return capitalize(salary);
//   }
// }

// final formatCurrency = NumberFormat("#,##0", "en_US");
// String firstName(String fullName) {
//   List<String> nameParts = fullName.split(' ');
//   String firstName = nameParts.isNotEmpty ? nameParts[0] : "";
//   return firstName;
// }

// Future<File?> pickImageFromGallery() async {
//   final picker = ImagePicker();
//   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//   if (pickedImage != null) {
//     return File(pickedImage.path);
//   }
//   return null;
// }

Future pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
  );
  if (result != null) {
    return File(result.files.first.path!);
  }
}

// bool isDatePassed(DateTime date) {
//   DateTime currentDate = dateToday;
//   return currentDate.isAfter(date);
// }

// String capitalize(String word) {
//   if (word.isEmpty) {
//     return word;
//   }
//   return word[0].toUpperCase() + word.substring(1);
// }

String toCamelCase(String phrase) {
  if (phrase.isEmpty) {
    return phrase;
  }
  List<String> words = phrase.split(' ');
  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
  }
  return words.join(' ');
}

Color getColorFromMaterialColorString(String materialColorString) {
  // Use a regular expression to find the color hex value in the string
  final hexColorRegex = RegExp(r'Color\(0x([0-9a-fA-F]+)\)');
  final match = hexColorRegex.firstMatch(materialColorString);

  if (match != null) {
    // Extract the hex value
    String hexColorString =
        match.group(1) ?? "FFFFFFFF"; // Default to white if not found
    return Color(int.parse(hexColorString, radix: 16));
  } else {
    throw Exception("Invalid MaterialColor string format.");
  }
}

compressAndGetFile(File file, String targetPath) async {
  XFile? result;
  try {
    result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 40, rotate: 0);
  } catch (err) {
    return XFile(file.path);
  }
  return result;
}


// String getFileType(String filePath) {
//   String ext = extension(filePath).toLowerCase();
//   if (ext == '.pdf') {
//     return 'pdf';
//   } else if (ext == '.jpg' || ext == '.jpeg' || ext == '.png') {
//     return 'image';
//   } else {
//     return 'unknown';
//   }
// }

// // Example usage
// checkFileType(String filePath) {
//   String fileType = getFileType(filePath);
//   switch (fileType) {
//     case 'pdf':
//       return 'pdf';
//     case 'image':
//       return 'image';
//     default:
//   }
// }

// String formatTimeWithMeridian(DateTime dateTime) {
//   return DateFormat('h:mm a').format(dateTime);
// }

// String formatTimeOfDay(TimeOfDay timeOfDay) {
//   final now = DateTime.now();
//   final DateTime dateTime =
//       DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
//   return DateFormat.jm().format(dateTime);
// }

// Future<int> getImageSize(String imagePath) async {
//   try {
//     File file = File(imagePath);
//     int size = await file.length();
//     return size;
//   } catch (e) {
//     return -1;
//   }
// }

// Future checkImageSize(String imagePath) async {
//   int size = await getImageSize(imagePath);
//   if (size >= 0) {
//     return bytesToMegabytes(size);
//   } else {}
// }

// double bytesToMegabytes(int bytes) {
//   return bytes / (1024 * 1024);
// }

// int calculateAge(String birthDateString) {
//   DateTime birthDate =
//       DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(birthDateString);
//   DateTime today = DateTime.now();
//   int age = today.year - birthDate.year;
//   if (today.month < birthDate.month ||
//       (today.month == birthDate.month && today.day < birthDate.day)) {
//     age--;
//   }
//   return age;
// }

// Future<int> calculateRemainingDays(DateTime expirationDate) async {
//   try {
//     DateTime currentTime = await NTP.now();
//     Duration remainingTime = expirationDate.difference(currentTime);
//     int remainingDays = remainingTime.inDays;
//     return remainingDays;
//   } catch (e) {
//     return -1;
//   }
// }

// downloadImage(
//     String fileName, String path, String originalName, String mimeType) {
//   String imagePath = "${EndPoints.baseUrl}/download-file";
//   String imageUrl =
//       "$imagePath?filename=$fileName&path=$path&originalname=$originalName&mimetype=$mimeType";
//   return imageUrl;
// }

// void openLink(String url) async {
//   if (!await launchUrl(Uri.parse(url))) {
//     throw 'Could not launch $url';
//   }
// }

// Future<void> openFile(File file) async {
//   final result = await OpenFile.open(file.path);
//   if (result.type != ResultType.done) {
//     SnackBarWidget.showSnackBar(ctx, "Could not open file");
//   }
// }

// void makePhoneCall(String phone) async {
//   if (await canLaunchUrl(Uri(scheme: 'tel', path: phone))) {
//     await launchUrl(Uri(scheme: 'tel', path: phone));
//   } else {
//     throw 'Could not launch $phone';
//   }
// }

// void emailTo(String email) async {
//   final Uri emailLaunchUri = Uri(
//     scheme: 'mailto',
//     path: email,
//     query: encodeQueryParameters(<String, String>{
//       'subject': '',
//     }),
//   );
//   if (!await launchUrl(emailLaunchUri)) {
//     throw 'Could not launch $emailLaunchUri';
//   }
// }

// String? encodeQueryParameters(Map<String, String> params) {
//   return params.entries
//       .map((MapEntry<String, String> e) =>
//           '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
//       .join('&');
// }

// changeAge(String selectedAgeRange) async {
//   String ageRangeInput = selectedAgeRange;
//   List<int> ageRange = parseAgeRange(ageRangeInput);
//   DateTime currentDateTime = await NTP.now();
//   var maxBirthdate = calculateBirthdate(ageRange[0], currentDateTime);
//   var minBirthdate = calculateBirthdate(ageRange[1] + 1, currentDateTime);
//   filterData["age1"] =
//       ageRange[0] == 0 ? "" : DateFormat('yyyy-MM-dd').format(maxBirthdate);
//   filterData["age2"] = DateFormat('yyyy-MM-dd').format(minBirthdate);
// }

// List<int> parseAgeRange(String ageRangeInput) {
//   List<String> parts = [];
//   if (ageRangeInput == "> 51") {
//     parts = ageRangeInput.split(
//       "> ",
//     );
//   } else {
//     parts = ageRangeInput.split(
//       " - ",
//     );
//   }
//   int minAge = parts[0] == "" ? 0 : int.parse(parts[0]);
//   int maxAge = int.parse(parts[1]);
//   return [minAge, maxAge];
// }

// DateTime calculateBirthdate(int age, DateTime currentDate) {
//   int birthYear = currentDate.year - age;
//   return DateTime(birthYear, currentDate.month, currentDate.day);
// }

// bool containsHtml(String text) {
//   final htmlRegex = RegExp(r"<[^>]*>");
//   return htmlRegex.hasMatch(text);
// }
