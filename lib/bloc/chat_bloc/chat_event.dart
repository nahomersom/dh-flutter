// ignore_for_file: prefer_typing_uninitialized_variables

part of 'chat_bloc.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class GetMyPrivateChatsEvent extends ChatEvent {
  // final String role;
  const GetMyPrivateChatsEvent();
}

class GetSingleChatsEvent extends ChatEvent {
  final String recieverId;
  const GetSingleChatsEvent({required this.recieverId});
}

class SendPrivateMessageEvent extends ChatEvent {
  final String recieverId;
  final String content;
  final String type;

  const SendPrivateMessageEvent(
      {required this.recieverId, required this.content, required this.type});
}

class FilterChatUsersEvent extends ChatEvent {
  final String key;
  const FilterChatUsersEvent(this.key);
}

//single chat events
abstract class SingleChatEvent {
  const SingleChatEvent();
}

class FetchSingleChatEvent extends SingleChatEvent {
  final String id;
  const FetchSingleChatEvent({required this.id});
}

class FetchSingleChatFromScoketEvent extends SingleChatEvent {
  final MessageModel message;
  const FetchSingleChatFromScoketEvent({required this.message});
}

// socket chat events
abstract class SocketChatEvent {
  const SocketChatEvent();
}

class GetMatchedUsersChatEvent extends SocketChatEvent {
  const GetMatchedUsersChatEvent();
}

class OnlineOfflineStatus extends ChatEvent {
  const OnlineOfflineStatus();
}

class GetUsersChatFromSocketEvent extends SocketChatEvent {
  final user;
  const GetUsersChatFromSocketEvent(this.user);
}

// count chat event
class CountChatEvent {
  const CountChatEvent();
}

class CountUserChatEvent extends CountChatEvent {
  const CountUserChatEvent();
}
