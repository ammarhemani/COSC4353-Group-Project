import 'package:cosc4353_volunteer_app/main.dart';
import 'package:cosc4353_volunteer_app/services/firebase_provider.dart';
import 'package:cosc4353_volunteer_app/services/snack_bar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeData>((event, emit) async {
      emit(HomeLoading());
      try {
        await FirebaseProvider.fetchProfileData();
        // await FirebaseProvider.fetchVolunteerHistory();
        await FirebaseProvider.fetchNotifications();
        // await FirebaseProvider.fetchVolunteerMatching(); ??
        emit(HomeLoaded());
      } catch (e) {
        emit(HomeError());
        print(e);
        SnackBarHelper.showWarningSnackBar(VolunteerApp.rootNavigatorKey.currentContext!, e.toString());
      }
    });
  }
}
