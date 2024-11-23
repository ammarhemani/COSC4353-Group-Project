import 'package:cosc4353_volunteer_app/main.dart';
import 'package:cosc4353_volunteer_app/models/notification.dart';
import 'package:cosc4353_volunteer_app/services/firebase_provider.dart';
import 'package:cosc4353_volunteer_app/services/snack_bar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<FetchNotificationsData>((event, emit) async {
      emit(NotificationsLoading());
      try {
        final List<Notification> notifications = await FirebaseProvider.fetchNotifications();
        emit(NotificationsLoaded(notifications));
      } catch (e) {
        emit(NotificationsError());
        print(e);
        SnackBarHelper.showWarningSnackBar(VolunteerApp.rootNavigatorKey.currentContext!, e.toString());
      }
    });
  }
}
