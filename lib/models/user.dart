import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosc4353_volunteer_app/main.dart';
import 'package:cosc4353_volunteer_app/models/address.dart';
import 'package:cosc4353_volunteer_app/screens/login_screen.dart';
import 'package:cosc4353_volunteer_app/services/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

enum UserType { volunteer, administrator }

class User {
  static User instance = User._internal();

  firebase.User? firebaseUser;
  String? firstName;
  String? lastName;
  String? email;
  Address? address = Address();
  Map<String, bool>? skills;
  String? preferences;
  List<DateTime>? availabilityDates;
  UserType? userType;

  User._internal();

  User({
    this.firebaseUser,
    this.firstName,
    this.lastName,
    this.email,
    this.address,
    this.skills,
    this.preferences,
    this.availabilityDates,
    this.userType,
  }) {
    address ??= Address();
    userType ??= UserType.volunteer;
  }

  void updateUserInstance(User updatedUserObject) {
    firstName = updatedUserObject.firstName;
    lastName = updatedUserObject.lastName;
    address?.copyWith(updatedUserObject.address);
    skills = updatedUserObject.skills;
    preferences = updatedUserObject.preferences;
    availabilityDates = updatedUserObject.availabilityDates;
    userType = updatedUserObject.userType;
  }

  Map<String, dynamic> toFirestoreMap() {
    final map = <String, dynamic>{
      "first_name": firstName,
      "last_name": lastName,
      "address": address?.toMap(),
      "skills": skills,
      "preferences": preferences,
      "availability_dates": availabilityDates,
      "user_type": userType.toString().split('.').last,
    };
    return map;
  }

  User fromFirestore(Map<String, dynamic>? json) {
    firstName = json?["first_name"];
    lastName = json?["last_name"];
    address = Address.fromJson(json?["address"]);
    skills = json?["skills"].cast<String, bool>();
    preferences = json?["preferences"];
    availabilityDates = (json?["availability_dates"] as List).map((timestamp) => (timestamp as Timestamp).toDate()).toList();
    print("Heree");
    print(json?["user_type"]);
    userType = UserType.values.firstWhere((element) => element.toString().split('.').last == json?["user_type"]);
    print("Heree 2");
    return instance;
  }

  Future<void> logoutUser() async {
    try {
      await FirebaseProvider.logoutUser();
      instance = User._internal();
    } catch (e) {
      print(e);
    }

    instance = User._internal();

    VolunteerApp.rootNavigatorKey.currentState?.pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
  }
}
