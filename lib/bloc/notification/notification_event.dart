part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

class GetMyNotificationsEvent extends NotificationEvent {
  GetMyNotificationsEvent();
}

class ChangeNotificationStatusEvent extends NotificationEvent {
  final int id;
  ChangeNotificationStatusEvent({required this.id});
}
