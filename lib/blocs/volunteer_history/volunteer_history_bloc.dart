import 'package:cosc4353_volunteer_app/main.dart';
import 'package:cosc4353_volunteer_app/models/event.dart';
import 'package:cosc4353_volunteer_app/services/firebase_provider.dart';
import 'package:cosc4353_volunteer_app/services/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'volunteer_history_event.dart';
part 'volunteer_history_state.dart';

class VolunteerHistoryBloc extends Bloc<VolunteerHistoryEvent, VolunteerHistoryState> {
  VolunteerHistoryBloc() : super(VolunteerHistoryInitial()) {
    on<FetchVolunteerHistory>((event, emit) async {
      emit(VolunteerHistoryLoading());
      try {
        final events = await FirebaseProvider.fetchVolunteerHistory();
        emit(VolunteerHistoryLoaded(events));
      } catch (e) {
        emit(VolunteerHistoryError());
        print(e);
        SnackBarHelper.showWarningSnackBar(VolunteerApp.rootNavigatorKey.currentContext!, e.toString());
      }
    });
  }
}
