import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cosc4353_volunteer_app/main.dart';
import 'package:cosc4353_volunteer_app/models/user.dart';
import 'package:cosc4353_volunteer_app/services/firebase_provider.dart';
import 'package:cosc4353_volunteer_app/services/snack_bar_helper.dart';
import 'package:flutter/foundation.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        await FirebaseProvider.updateProfile(event.updatedUserObj);
        User.instance.updateUserInstance(event.updatedUserObj);
        emit(ProfileUpdated());
      } catch (e) {
        emit(ProfileError());
        SnackBarHelper.showWarningSnackBar(VolunteerApp.rootNavigatorKey.currentContext!, e.toString());
      }
    });
  }
}
