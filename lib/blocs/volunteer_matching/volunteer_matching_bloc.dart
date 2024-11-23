import 'package:cosc4353_volunteer_app/main.dart';
import 'package:cosc4353_volunteer_app/models/event.dart';
import 'package:cosc4353_volunteer_app/models/user.dart';
import 'package:cosc4353_volunteer_app/services/firebase_provider.dart';
import 'package:cosc4353_volunteer_app/services/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'volunteer_matching_event.dart';
part 'volunteer_matching_state.dart';

class VolunteerMatchingBloc extends Bloc<VolunteerMatchingEvent, VolunteerMatchingState> {
  VolunteerMatchingBloc() : super(VolunteerMatchingInitial()) {
    on<FetchPotentialCandidates>((event, emit) async {
      emit(VolunteerMatchingLoading());
      try {
        final candidates = await FirebaseProvider.fetchPotentialCandidates(event.event);
        emit(VolunteerMatchingLoaded(candidates));
      } catch (e) {
        emit(VolunteerMatchingError());
        print(e);
        SnackBarHelper.showWarningSnackBar(VolunteerApp.rootNavigatorKey.currentContext!, e.toString());
      }
    });
  }
}
