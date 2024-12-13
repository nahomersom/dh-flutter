import 'package:dh_flutter_v2/repository/auth_repository.dart';
import 'package:dio/dio.dart';

import '../constants/constants.dart';
import '../model/message_model.dart';
import '../model/models.dart';
import '../utils/utils.dart';

class ChatRepository {
  AuthRepository authRepository = AuthRepository();

  Future getSingleChat(String receiverId) async {
    User info = await authRepository.getUserData();

    try {
      Dio dio = Dio();
      dio.options.headers = await RequestHeader().authorisedHeader();

      String filters =
          "?filter[0][0][field]=senderId&filter[0][0][operator]==&filter[0][0][value]=${info.id}&filter[0][1][field]=receiverId&filter[0][1][operator]==&filter[0][1][value]=${info.id}&filter[1][0][field]=senderId&filter[1][0][operator]==&filter[1][0][value]=$receiverId&filter[1][1][field]=receiverId&filter[1][1][operator]==&filter[1][1][value]=$receiverId&orderBy[0][field]=createdAt&orderBy[0][direction]=asc";

      var response = await dio
          .get('${EndPoints.getMyPrivateChatHistory}$filters')
          .timeout(Duration(seconds: time_out));

      List<MessageModel> messageData = (response.data['data'] as List)
          .map(
            (message) => MessageModel.fromJson(message),
          )
          .toList();
      messages = messageData;
      messages = messages.reversed.toList();

      return messageData;
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == ApiResponse.unAuthorized) {
        await authRepository.refreshToken();

        return getSingleChat(receiverId);
      } else {
        handleApiError(e);
      }
    }
  }

  Future getMyPrivateChats() async {
    try {
      Dio dio = Dio();
      dio.options.headers = await RequestHeader().authorisedHeader();

      var response = await dio.get(EndPoints.getMyChatLists);
      // .timeout(Duration(seconds: time_out));

      logger("chats", response.data);

      List<User> peopleChatWithMe = (response.data["chats"] as List)
          .map(
            (message) => User.fromJson(message),
          )
          .toList();
      return peopleChatWithMe;
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == ApiResponse.unAuthorized) {
        await authRepository.refreshToken();

        return getMyPrivateChats();
      } else {
        handleApiError(e);
      }
    }
  }

  Future changeChatStatus(String id) async {
    try {
      Dio dio = Dio();
      dio.options.headers = await RequestHeader().authorisedHeader();

      await dio.post(EndPoints.changeChatStatus,
          data: {"senderId": id}).timeout(Duration(seconds: time_out));
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == ApiResponse.unAuthorized) {
        await authRepository.refreshToken();

        return changeChatStatus(id);
      } else {
        handleApiError(e);
      }
    }
  }

  Future sendMessage(String id, String content, String type) async {
    try {
      Dio dio = Dio();
      dio.options.headers = await RequestHeader().authorisedHeader();

      await dio.post(EndPoints.sendPrivateMessage, data: {
        "receiverId": id,
        "content": content,
        "type": type
      }).timeout(Duration(seconds: time_out));
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == ApiResponse.unAuthorized) {
        await authRepository.refreshToken();

        return sendMessage(id, content, type);
      } else {
        handleApiError(e);
      }
    }
  }

  // Future countChat() async {
  //   try {
  //     Dio dio = Dio();
  //     dio.options.headers = await RequestHeader().authorisedHeader();

  //     final response = await dio
  //         .get(EndPoints.countUnreadMessages)
  //         .timeout(Duration(seconds: time_out));
  //     return response.data['total'];
  //   } catch (e) {
  //     if (e is DioException &&
  //         e.response != null &&
  //         e.response!.statusCode == ApiResponse.unAuthorized) {
  //       await authRepository.refreshToken();

  //       return countChat();
  //     } else {
  //       handleApiError(e);
  //     }
  //   }
  // }

  // Future deleteSingleMessage(String id) async {
  //   try {
  //     Dio dio = Dio();
  //     dio.options.headers = await RequestHeader().authorisedHeader();

  //     final response = await dio
  //         .delete('${EndPoints.deleteSingleMessage}/$id')
  //         .timeout(Duration(seconds: time_out));

  //     return response.data == "true" ? true : false;
  //   } catch (e) {
  //     if (e is DioException &&
  //         e.response != null &&
  //         e.response!.statusCode == ApiResponse.unAuthorized) {
  //       await authRepository.refreshToken();

  //       return deleteSingleMessage(id);
  //     } else {
  //       handleApiError(e);
  //     }
  //   }
  // }
}
