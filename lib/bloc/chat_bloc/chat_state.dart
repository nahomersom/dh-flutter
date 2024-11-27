part of 'chat_bloc.dart';

abstract class ChatState{
  const ChatState();

  
}

class ChatInitial extends ChatState {}

class GetMyPrivateChatsLoading extends ChatState {}

class GetMyPrivateChatsSuccess extends ChatState {
  final List<User> peopleChatWithme;
  const GetMyPrivateChatsSuccess({required this.peopleChatWithme});
}

class GetMyPrivateChatsError extends ChatState {
  final String errorMessage;
  const GetMyPrivateChatsError({required this.errorMessage});
}

class GetSingleChatsLoading extends ChatState {}

class GetSingleChatsSuccess extends ChatState {
  const GetSingleChatsSuccess();
}

class GetSingleChatsError extends ChatState {
  final String errorMessage;
  const GetSingleChatsError({required this.errorMessage});
}




// single chat states
class SingleChatState{
  const SingleChatState();

 
}

class SingleChatStateLoad extends SingleChatState {}

class FetchSingleChatLoading extends SingleChatState {}

class FetchSingleChatSuccess extends SingleChatState {}

class FetchSingleChatFailure extends SingleChatState {
  final String message;
  const FetchSingleChatFailure({required this.message});
}

// socket chat states
class SocketChatState{
  const SocketChatState();
 
}

class GetUsersLoading extends SocketChatState {}

class GetUsersSuccess extends SocketChatState {
  final List<ChatModel> users;
  const GetUsersSuccess({required this.users});
}

class GetUsersFailure extends SocketChatState {
  final String? message;
  const GetUsersFailure({this.message});
}

//chat counter state
class CountChatState{
  const CountChatState();

  
}

class CountChatStateLoad extends CountChatState {}

class CountChatLoading extends CountChatState {}

class CountChatSuccess extends CountChatState {
  final int totalMessage;
  const CountChatSuccess({required this.totalMessage});
}

class CountChatFailure extends CountChatState {
  final String message;
  const CountChatFailure({required this.message});
}
