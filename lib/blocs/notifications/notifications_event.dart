part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsEvent {
  const NotificationsEvent();
}

class FetchNotificationsData extends NotificationsEvent {}
