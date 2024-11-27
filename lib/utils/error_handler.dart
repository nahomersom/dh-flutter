import 'dart:async';
import 'dart:io';

import 'package:dh/utils/helper.dart';
import 'package:dio/dio.dart';

void handleApiError(dynamic e) {
  logger("er $e", {});
  if (e is TimeoutException) {
    throw ("Request took too long!");
  } else {
    if (e is DioException) {
      if (e.error is SocketException) {
        SocketException exception = e.error as SocketException;
        if (exception.osError?.errorCode == 101 ||
            exception.osError?.errorCode == 7 ||
            exception.osError?.errorCode == 50) {
          throw ("No internet connection found! Verify your connection and try again.");
        } else {
          throw ("Hmm, it seems your network connection is unstable. Please check your signal strength and try again in a moment.");
        }
      }
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          throw ("Resource not found!");
        } else {
          throw (e.response!.data["message"]);
        }
      } else {
        throw ("Something went wrong!");
      }
    } else {
      throw ("Something went wrong!");
    }
  }
}
