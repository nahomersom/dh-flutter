// ignore_for_file: empty_catches

import 'package:dh/bloc/chat_bloc/chat_bloc.dart';
import 'package:dh/repository/auth_repository.dart';
import 'package:dh/utils/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../constants/constants.dart';

late io.Socket socket;
bool isConnected = false;
void connectAndListen(int id) async {
  var token = await AuthRepository().getToken();
  logger("#######connecting, $token ${EndPoints.socketUrl}", {});
  socket = io.io(
      // EndPoints.socketUrl,
      // <String, dynamic>{
      //   'autoConnect': false,
      //   'auth': {"token": "Bearer $token"},
      //   'transports': ['websocket'],
      // });

      EndPoints.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({"token": "Bearer $token"}) 
          .disableAutoConnect()
          .build());

  if (!socket.connected) {
    logger("#######connecting...", {});
    socket.connect();
  }

  socket.onConnect((data) {
    logger("#######connected", {});
  });
  socket.onDisconnect((data) {
    isConnected = false;
  });
  logger("#######connect###", {});

  socket.on("newMessage", (data) {
    logger("new message $data", {});
    BlocProvider.of<ChatBloc>(ctx).add(const GetMyPrivateChatsEvent());
  });
}

void sendMessage(String body, int receiverId, String type) {
  var message = {
   { "content": body.trim(),
    "type": type,
    "receiverId": receiverId}
  };
  logger("send message $message", {});
  socket.emit("sendMessage", message);

  BlocProvider.of<ChatBloc>(ctx).add(const GetMyPrivateChatsEvent());
}

void sendGroupMessage(String body, String senderId) {
  var message = {
    {"body": body.trim(), "senderId": senderId}
  };

  socket.emit("groupMessage", message);

  // BlocProvider.of<ChatBloc>(ctx).add(const GetMyChatsEvent());
}

void closeSocket() {
  if (socket.active) {
    socket.close();
  }
}
