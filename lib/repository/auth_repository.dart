import 'dart:async';
import 'dart:io';

import 'package:dh_flutter_v2/model/models.dart';
import 'package:dh_flutter_v2/routes/custom_page_route.dart';
import 'package:dh_flutter_v2/screens/screens.dart';
import 'package:dh_flutter_v2/utils/error_handler.dart';
import 'package:dh_flutter_v2/utils/helper.dart';
import 'package:dh_flutter_v2/utils/socket_connection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/constants.dart';

class AuthRepository {
  final secureStorage = const FlutterSecureStorage();

  AuthRepository();
  Future refreshToken() async {
    AuthResponse data = await getUserData();
    String? refreshToken = data.accessToken;
    Dio dio = Dio();
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${data.accessToken}',
      "x-refresh-token": refreshToken
    };
    try {
      Response response = await dio
          .post(
            EndPoints.refresh,
          )
          .timeout(AppConstants.timeout);
      var output = response.data;
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        logger("title", response.data);
        await secureStorage.write(
            key: 'access_token_dh', value: output['accessToken']);
        return true;
      }
    } catch (e) {
      // closeSocket();

      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == ApiResponse.unAuthorized) {
        gotoSignIn(ctx);
      } else {
        handleApiError(e);
      }
    }
  }

  Future sendOtp(String phone) async {
    logger("SEND OTP ${EndPoints.sendCode} $phone", {});

    Dio dio = Dio();
    dio.options.headers = await RequestHeader().defaultHeader();
    try {
      Response response =
          await dio.post(EndPoints.sendCode, data: {"phone": phone});
      // .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("", output);
        if (output["acknowledge"] == "success") {
          return output;
        } else {
          return output;
        }
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future verifyOtp(String phoneNumber, String otp) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().defaultHeader();
    logger("$phoneNumber $otp", {});
    try {
      Response response = await dio.post(EndPoints.verifyCode, data: {
        "phone": phoneNumber,
        "otpCode": otp,
        "deviceId": myFcmId
      }).timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        logger("$phoneNumber $otp", response.data);
        AuthResponse authResponse = AuthResponse.fromJson(response.data);
        await secureStorage.write(
            key: 'refresh_token_dh', value: authResponse.accessToken);
        authResponse.user.profileImage != null
            ? await secureStorage.write(
                key: 'profileImage', value: authResponse.user.profileImage)
            : null;
        await secureStorage.write(
            key: 'access_token_dh', value: authResponse.accessToken);
        authResponse.user.id != null
            ? await secureStorage.write(
                key: "id", value: authResponse.user.id.toString())
            : null;
        authResponse.user.firstName != null
            ? await secureStorage.write(
                key: "firstName", value: authResponse.user.firstName.toString())
            : null;

        connectAndListen(authResponse.user.id!);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future completeProfile(String firstName, String middleName, String lastName,
      File? profileImage) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();

    try {
      FormData formData = FormData.fromMap({
        "firstName": firstName.trim(),
        "middleName": middleName.trim(),
        "lastName": lastName.trim(),
        "file": await MultipartFile.fromFile(profileImage!.path),
      });

      Response response = await dio
          .post(
            EndPoints.completeProfile,
            data: formData,
          )
          .timeout(AppConstants.timeout);

      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("", output);
        User user = User.fromJson(response.data["user"]);
        await secureStorage.write(
            key: "firstName", value: user.firstName.toString());
        await secureStorage.write(key: "id", value: user.id.toString());
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future login(String phone, String password, String type) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().defaultHeader();
    final formData = {
      "phoneNumber": phone,
      "password": password,
      "type": type.toLowerCase(),
      // "fcmId": myFcmId["fcm_id"]
    };
    try {
      Response response = await dio
          .post(
            EndPoints.login,
            data: formData,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        final output = response.data;

        userId = output['profile']['id'];
        userPhone = output['profile']['phoneNumber'];
        userRole = output['profile']['type'];
        userName = output['profile']['name'];
        accessToken = output['accessToken'];
        refereshToken = output['refreshToken'];
        if (output['profile']['twoFactorAuthentication'] ?? false) {
        } else {
          // await setUser();
        }
        // connectAndListen(output['profile']['id'] ?? "");
        return response.data;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future checkPhoneNumber(String phone) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().defaultHeader();
    try {
      logger("check User   '${EndPoints.checkUser}/$phone'", {});
      Response response = await dio
          .get(
            '${EndPoints.checkUser}/$phone',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        logger("check User", response.data);
        return true;
      }
    } catch (e) {
      handleApiError(e);
      return false;
    }
  }
  // Future approveProfile(String phone) async {
  //   Dio dio = Dio();
  //   dio.options.headers = await RequestHeader().defaultHeader();
  //   try {
  //     logger("check User   '${EndPoints.checkUser}/$phone'", {});
  //     Response response = await dio
  //         .get(
  //           '${EndPoints.checkUser}/$phone',
  //         )
  //         .timeout(AppConstants.timeout);
  //     if (response.statusCode == ApiResponse.requestSuccess ||
  //         response.statusCode == ApiResponse.requestCreated) {
  //       logger("check User", response.data);
  //       return true;
  //     }
  //   } catch (e) {
  //     handleApiError(e);
  //     return false;
  //   }
  // }

  Future resetPassword(String phone, String password, String confirmPassword,
      String type) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().defaultHeader();

    final formData = {
      "password": password.trim(),
      "confirmPassword": confirmPassword.trim(),
      "phoneNumber": phone,
      "type": type.toLowerCase(),
    };
    try {
      Response response = await dio
          .post(
            EndPoints.resetPassword,
            data: formData,
          )
          .timeout(AppConstants.timeout);

      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        return response.data;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future changePassword(
      String password, String currentPassword, String confirmPassword) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    final formData = {
      "password": password.trim(),
      "currentPassword": currentPassword.trim(),
      "confirmPassword": confirmPassword.trim(),
    };
    try {
      Response response = await dio
          .post(
            EndPoints.changePassword,
            data: formData,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        return response.data;
      }
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == ApiResponse.unAuthorized) {
        refreshToken();
        return changePassword(password, currentPassword, confirmPassword);
      } else {
        handleApiError(e);
      }
    }
  }

  Future logout(context) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      final response = await dio
          .post(
            EndPoints.logout,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        await clearData();
      }
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == ApiResponse.unAuthorized) {
        refreshToken();
        return logout(context);
      } else {
        handleApiError(e);
      }
    }
  }

  Future getUserWithPhone() async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            EndPoints.getIndustries,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("get user with phone number", output);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getUserProfile() async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            EndPoints.getMe,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        User user = User.fromJson(output["user"]);
        logger("GET ME", output);

        return user;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getAllUsers() async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            EndPoints.getAllUsers,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("GET all users", output);
        List<User> users = [];
        for (var user in output) {
          users.add(User.fromJson(user));
        }

        return users;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future searchUsers(String value) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            '${EndPoints.searchUsers}/?search=$value',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("search users", output);
        List<User> users = [];
        for (var user in output) {
          users.add(User.fromJson(user));
        }

        return users;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future deleteAccount(String id, String role) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .delete(
            role == "employer"
                ? '${EndPoints.deleteEmployer}/$id'
                : '${EndPoints.deleteEmployee}/$id',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        userData = {};

        await clearData();
      }
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == ApiResponse.unAuthorized) {
        refreshToken().then((value) => deleteAccount(id, role));
      } else {
        handleApiError(e);
      }
    }
  }

//   Future<String?> getloginAttempts() async {
//     return await secureStorage.read(key: "login_attempts");
//   }

//   Future setloginAttempts(String attempt) async {
//     return await secureStorage.write(key: "login_attempts", value: attempt);
//   }

  // setUser() async {
  //   await secureStorage.write(key: 'phone_number', value: userPhone);
  //   await secureStorage.write(key: 'name', value: userName);
  //   await secureStorage.write(
  //       key: 'refresh_token_emebet', value: refereshToken);
  //   await secureStorage.write(key: 'access_token_emebet', value: accessToken);
  //   await secureStorage.write(key: "id", value: userId);
  //   await secureStorage.write(key: "role", value: userRole);
  // }

  Future<String?> getToken() async {
    return await secureStorage.read(key: "access_token_dh");
  }

  Future clearData() async {
    return await secureStorage.deleteAll();
  }

//   Future<String?> getRefreshToken() async {
//     return await secureStorage.read(key: "refresh_token_emebet");
//   }

  Future getUserData() async {
    final data = await secureStorage.readAll();
    logger("$data", {});
    return User.fromStorage(data);
  }
}

void gotoSignIn(BuildContext context) {
  AuthRepository().logout(context);
  AuthRepository().clearData();
  Navigator.pushAndRemoveUntil(
      context,
      customPageRoute(const SignInScreen(
        newUser: false,
      )),
      (route) => false);
}
