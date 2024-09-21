import 'package:cosc4353_volunteer_app/screens/create_event_screen.dart';
import 'package:cosc4353_volunteer_app/screens/home_screen.dart';
import 'package:cosc4353_volunteer_app/screens/login_screen.dart';
import 'package:cosc4353_volunteer_app/screens/landing_screen.dart';
import 'package:cosc4353_volunteer_app/screens/notifications_screen.dart';
import 'package:cosc4353_volunteer_app/screens/profile_screen.dart';
import 'package:cosc4353_volunteer_app/screens/register_screen.dart';
import 'package:cosc4353_volunteer_app/screens/volunteer_history_screen.dart';
import 'package:cosc4353_volunteer_app/screens/volunteer_matching_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const VolunteerApp());
}

class VolunteerApp extends StatelessWidget {
  const VolunteerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer App',
      debugShowCheckedModeBanner: false,
      initialRoute: LandingScreen.id,
      routes: {
        LandingScreen.id: (context) => LandingScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        NotificationsScreen.id: (context) => NotificationsScreen(),
        CreateEventScreen.id: (context) => CreateEventScreen(),
        VolunteerHistoryScreen.id: (context) => VolunteerHistoryScreen(),
        VolunteerMatchingScreen.id: (context) => VolunteerMatchingScreen(),
      },
    );
  }
}
