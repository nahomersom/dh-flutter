

// import 'package:dh/constants/app_constants.dart';
// import 'package:flutter/material.dart';

// class InternetConnectivity {
//   Future<bool> checkInternetConnectivty(ctx, bool action) async {
//     bool isConnected = await InternetConnectionChecker().hasConnection;
//     if (isConnected) {
//       return true;
//     } else {
//       action
//           ? ScaffoldMessenger.of(ctx).showSnackBar( SnackBar(
//               backgroundColor: Colors.red,
//               content: Text(
//              "no_internet",
//                 style: const TextStyle(
//                   fontSize: AppConstants.mediumFont,
//                   fontWeight: FontWeight.normal,
//                   color: AppConstants.grey100,
//                 ),
//               ),
//               duration: const Duration(seconds: 2),
//             ))
//           : null;
//       return false;
//     }
//   }
// }
