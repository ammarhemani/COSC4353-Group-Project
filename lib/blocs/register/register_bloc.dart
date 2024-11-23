import 'package:cosc4353_volunteer_app/main.dart';
import 'package:cosc4353_volunteer_app/services/firebase_provider.dart';
import 'package:cosc4353_volunteer_app/services/snack_bar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<FormSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        await FirebaseProvider.registerUser(event);
        emit(RegisterLoaded());
      } catch (e) {
        emit(RegisterError());
        print(e.toString());
        SnackBarHelper.showWarningSnackBar(VolunteerApp.rootNavigatorKey.currentContext!, e.toString());
      }
    });
  }
}
