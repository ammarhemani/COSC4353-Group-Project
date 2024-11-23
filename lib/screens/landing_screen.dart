import 'package:cosc4353_volunteer_app/screens/login_screen.dart';
import 'package:cosc4353_volunteer_app/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  static const String id = 'landing_screen';
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "VolunteerConnect",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text("Connect and manage volunteers with ease", textAlign: TextAlign.center),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
                      style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2)))),
                      child: Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, RegisterScreen.id),
                      style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2)))),
                      child: Text('Register'),
                    ),
                    // SizedBox(height: 24),
                    // ElevatedButton(
                    //   onPressed: () => Navigator.pushNamed(context, VolunteerMatchingScreen.id),
                    //   style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2)))),
                    //   child: Column(
                    //     children: const [
                    //       Text('Administrator Registration'),
                    //       Text('Not for public use', style: TextStyle(fontSize: 10)),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
