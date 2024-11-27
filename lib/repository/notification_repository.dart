import 'package:dh/model/notification_model.dart';
import 'package:dh/repository/repositories.dart';
import 'package:dh/utils/utils.dart';
import 'package:dio/dio.dart';

import '../constants/constants.dart';
import '../model/models.dart';

class NotificationRepository {
  AuthRepository authRepository = AuthRepository();

  Future getMyNotifications() async {
    Dio dio = Dio();
    logger("get my notifications", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            '${EndPoints.getMyNotification}?seen=false',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("get my notifications", output);
        List<NotificationModel> invitations = [];
        for (var invitation in output) {
          invitations.add(NotificationModel.fromJson(invitation));
        }

        return invitations;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future changeNotificationStatus(int id) async {
    Dio dio = Dio();
    logger("change notification status", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .patch(
            '${EndPoints.notifications}/$id',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("change notification status", output);
        List<NotificationModel> invitations = [];
        for (var invitation in output) {
          invitations.add(NotificationModel.fromJson(invitation));
        }

        return invitations;
      }
    } catch (e) {
      handleApiError(e);
    }
  }
}
