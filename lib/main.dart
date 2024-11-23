import 'package:cosc4353_volunteer_app/blocs/events/events_bloc.dart';
import 'package:cosc4353_volunteer_app/models/event.dart';
import 'package:cosc4353_volunteer_app/screens/create_event_screen.dart';
import 'package:cosc4353_volunteer_app/screens/events_screen.dart';
import 'package:cosc4353_volunteer_app/screens/home_screen.dart';
import 'package:cosc4353_volunteer_app/screens/login_screen.dart';
import 'package:cosc4353_volunteer_app/screens/landing_screen.dart';
import 'package:cosc4353_volunteer_app/screens/notifications_screen.dart';
import 'package:cosc4353_volunteer_app/screens/profile_screen.dart';
import 'package:cosc4353_volunteer_app/screens/register_screen.dart';
import 'package:cosc4353_volunteer_app/screens/volunteer_history_screen.dart';
import 'package:cosc4353_volunteer_app/screens/volunteer_matching_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cosc4353_volunteer_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const VolunteerApp());
}

class VolunteerApp extends StatelessWidget {
  const VolunteerApp({super.key});
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer App',
      debugShowCheckedModeBanner: false,
      initialRoute: LandingScreen.id,
      navigatorKey: rootNavigatorKey,
      routes: {
        LandingScreen.id: (context) => LandingScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        NotificationsScreen.id: (context) => NotificationsScreen(),
        CreateEventScreen.id: (context) => CreateEventScreen(eventsBloc: EventsBloc()),
        VolunteerHistoryScreen.id: (context) => VolunteerHistoryScreen(),
        VolunteerMatchingScreen.id: (context) => VolunteerMatchingScreen(event: Event()),
        EventsScreen.id: (context) => EventsScreen(),
      },
    );
  }
}
