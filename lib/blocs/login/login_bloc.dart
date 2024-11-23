import 'package:cosc4353_volunteer_app/main.dart';
import 'package:cosc4353_volunteer_app/services/firebase_provider.dart';
import 'package:cosc4353_volunteer_app/services/snack_bar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<FormSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        await FirebaseProvider.loginUser(event);
        emit(LoginLoaded());
      } catch (e) {
        emit(LoginError());
        print(e);
        SnackBarHelper.showWarningSnackBar(VolunteerApp.rootNavigatorKey.currentContext!, "Invalid email or password. Please try again.");
      }
    });
  }
}
