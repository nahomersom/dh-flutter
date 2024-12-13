part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {}

final class NotificationInitial extends NotificationState {}

class GetMyNotificationsLoading extends NotificationState {}

class GetMyNotificationsSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  GetMyNotificationsSuccess({
    required this.notifications
  });
}

class GetMyNotificationsFailure extends NotificationState {
  final String errorMessage;
  GetMyNotificationsFailure(this.errorMessage);
}
class ChangeNotificationStatusLoading extends NotificationState {}

class ChangeNotificationStatusSuccess extends NotificationState {
  ChangeNotificationStatusSuccess();
}

class ChangeNotificationStatusFailure extends NotificationState {
  final String errorMessage;
  ChangeNotificationStatusFailure(this.errorMessage);
}
