import 'package:cosc4353_volunteer_app/main.dart';
import 'package:cosc4353_volunteer_app/models/event.dart';
import 'package:cosc4353_volunteer_app/services/firebase_provider.dart';
import 'package:cosc4353_volunteer_app/services/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(EventsInitial()) {
    on<FetchEvents>((event, emit) async {
      emit(EventsLoading());
      try {
        final events = await FirebaseProvider.fetchEvents();
        emit(EventsLoaded(events));
      } catch (e) {
        emit(EventsError());
        print(e);
        SnackBarHelper.showWarningSnackBar(VolunteerApp.rootNavigatorKey.currentContext!, e.toString());
      }
    });
    on<CreateEvent>((event, emit) async {
      emit(EventsLoading());
      try {
        await FirebaseProvider.createEvent(event.event);
        Navigator.of(VolunteerApp.rootNavigatorKey.currentContext!).pop();
        SnackBarHelper.showSnackBar(VolunteerApp.rootNavigatorKey.currentContext!, "Event created successfully", Icon(Icons.check_circle, color: Colors.blue));
        add(FetchEvents());
      } catch (e) {
        emit(EventsError());
        print(e);
        SnackBarHelper.showWarningSnackBar(VolunteerApp.rootNavigatorKey.currentContext!, e.toString());
      }
    });
  }
}
