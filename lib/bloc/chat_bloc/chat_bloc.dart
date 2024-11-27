// ignore_for_file: empty_catches

import 'package:bloc/bloc.dart';
import 'package:dh/model/message_model.dart';
import 'package:dh/model/user_model.dart';

import '../../constants/constants.dart';
import '../../model/chat_model.dart';
import '../../repository/chat_repositor.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatRepository chatRepository;

  ChatBloc({required this.chatRepository}) : super(ChatInitial()) {
    on<GetMyPrivateChatsEvent>((event, emit) async {
      emit(GetMyPrivateChatsLoading());
      try {
        var res = await chatRepository.getMyPrivateChats();
        emit(GetMyPrivateChatsSuccess(peopleChatWithme: res));
      } catch (e) {
        emit(GetMyPrivateChatsError(errorMessage: e.toString()));
      }
    });
    on<GetSingleChatsEvent>((event, emit) async {
      emit(GetSingleChatsLoading());
      try {
        await chatRepository.getSingleChat(event.recieverId);
        emit(const GetSingleChatsSuccess());
      } catch (e) {
        emit(GetSingleChatsError(errorMessage: e.toString()));
      }
    });
    // on<OnlineOfflineStatus>((event, emit) async {
    //   try {
    //     var users = await teacherRepository.getPeoplesThatChatWithMe();
    //     emit(GetMyChatsLoading());
    //     emit(GetMyChatsSuccess(peopleChatWithme: users));
    //   } catch (err) {}
    // });
    // on<FilterChatUsersEvent>((event, emit) async {
    //   try {
    //     emit(GetMyChatsLoading());
    //     listOfChatUsers = [];
    //     for (var user in allChatUsers) {
    //       if (user.name!.toUpperCase().startsWith(event.key.toUpperCase())) {
    //         listOfChatUsers.add(user);
    //       }
    //     }

    //     emit(GetMyChatsSuccess(peopleChatWithme: listOfChatUsers));
    //   } catch (err) {
    //     emit(GetMyChatsError(errorMessage: err.toString()));
    //   }
    // });
  }
}

//single chat
class SingleChatBloc extends Bloc<SingleChatEvent, SingleChatState> {
  final ChatRepository chatRepository;

  SingleChatBloc({required this.chatRepository})
      : super(SingleChatStateLoad()) {
    on<FetchSingleChatEvent>((event, emit) async {
      try {
        emit(
          FetchSingleChatLoading(),
        );
        await chatRepository.getSingleChat(event.id);

        emit(FetchSingleChatSuccess());
      } catch (err) {
        emit(
          FetchSingleChatFailure(
            message: err.toString(),
          ),
        );
      }
    });
    on<FetchSingleChatFromScoketEvent>((event, emit) async {
      try {
        emit(
          FetchSingleChatLoading(),
        );

        messages.insert(0, event.message);

        emit(FetchSingleChatSuccess());
      } catch (err) {
        emit(
          FetchSingleChatFailure(
            message: err.toString(),
          ),
        );
      }
    });
  }
}

// socket chat
class SocketChatBloc extends Bloc<SocketChatEvent, SocketChatState> {
  final ChatRepository chatRepository;

  SocketChatBloc({
    required this.chatRepository,
  }) : super(GetUsersLoading()) {
    on<GetUsersChatFromSocketEvent>((event, emit) async {
      try {
        emit(GetUsersLoading());
        bool isExist = false;

        for (var user in listOfChatUsers) {
          if (user.id == event.user.id) {
            isExist = true;
          }
        }

        if (isExist) {
          listOfChatUsers.removeWhere((user) => user.id == event.user.id);
          listOfChatUsers.insert(0, event.user);
        } else {
          listOfChatUsers.insert(0, event.user);
        }

        emit(GetUsersSuccess(users: listOfChatUsers));
      } catch (err) {
        emit(GetUsersFailure(message: err.toString()));
      }
    });
  }
}

// count chats
// class ChatCountBloc extends Bloc<CountChatEvent, CountChatState> {
//   final ChatRepository chatRepository;

//   ChatCountBloc({required this.chatRepository}) : super(CountChatStateLoad()) {
//     on<CountUserChatEvent>((event, emit) async {
//       try {
//         emit(
//           CountChatLoading(),
//         );
//         int totalMessage = await chatRepository.countChat();

//         emit(CountChatSuccess(totalMessage: totalMessage));
//       } catch (err) {
//         emit(
//           CountChatFailure(
//             message: err.toString(),
//           ),
//         );
//       }
//     });
//   }
// }
