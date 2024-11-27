import 'package:bloc/bloc.dart';
import 'package:dh/model/models.dart';
import 'package:dh/repository/repositories.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationRepository notificationRepository = NotificationRepository();
  NotificationBloc({required this.notificationRepository})
      : super(NotificationInitial()) {
    on<GetMyNotificationsEvent>((event, emit) async {
      emit(GetMyNotificationsLoading());
      try {
        var res = await notificationRepository.getMyNotifications();
        emit(GetMyNotificationsSuccess(notifications: res));
      } catch (e) {
        emit(GetMyNotificationsFailure(e.toString()));
      }
    });
    on<ChangeNotificationStatusEvent>((event, emit) async {
      emit(ChangeNotificationStatusLoading());
      try {
        await notificationRepository.changeNotificationStatus(event.id);
        emit(ChangeNotificationStatusSuccess());
      } catch (e) {
        emit(ChangeNotificationStatusFailure(e.toString()));
      }
    });
  }
}
