import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosc4353_volunteer_app/blocs/login/login_bloc.dart' as login;
import 'package:cosc4353_volunteer_app/blocs/register/register_bloc.dart' as register;
import 'package:cosc4353_volunteer_app/models/event.dart';
import 'package:cosc4353_volunteer_app/models/notification.dart';
import 'package:cosc4353_volunteer_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class FirebaseProvider {
  static const usersCollection = "users";
  static const notificationsCollection = "notifications";
  static const eventsCollection = "events";

  ///Authentication: Login, register, reset pw, forget email
  static Future<void> loginUser(login.FormSubmitted event) async {
    // Authenticate FirebaseAuth
    final firebaseAuth = firebase.FirebaseAuth.instance;
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(email: event.email, password: event.password);
    print("user: ${userCredential.user}");

    // Fetch User data from Firestore
    final db = FirebaseFirestore.instance;
    final userDoc = await db.collection(usersCollection).doc(userCredential.user?.uid).get();
    print("userDoc: ${userDoc.data()}");

    // Assign to user instance
    User.instance.firebaseUser = userCredential.user;
    User.instance.fromFirestore(userDoc.data());
  }

  static Future<void> registerUser(register.FormSubmitted event) async {
    // Register with FirebaseAuth
    final firebaseAuth = firebase.FirebaseAuth.instance;
    final res = await firebaseAuth.createUserWithEmailAndPassword(email: event.email, password: event.password);

    // Add to firestore
    final db = FirebaseFirestore.instance;
    final user = {
      "email": event.email,
      "first_name": event.firstName,
      "last_name": event.lastName,
      "user_type": UserType.volunteer.toString().split('.').last,
    };
    await db.collection(usersCollection).doc(firebase.FirebaseAuth.instance.currentUser?.uid).set(user);

    // Assign to user instance
    User.instance.firebaseUser = res.user;
    User.instance.email = event.email;
    User.instance.firstName = event.firstName;
    User.instance.lastName = event.lastName;
  }

  static Future<void> updateProfile(User updatedUserObj) async {
    final db = FirebaseFirestore.instance;
    final doc = db.collection(usersCollection).doc(firebase.FirebaseAuth.instance.currentUser?.uid);
    await doc.update(updatedUserObj.toFirestoreMap());
    print("this is doc: ${(await doc.get()).toString()}");
  }

  ///Fetch Information
  static Future<void> fetchProfileData() async {
    final db = FirebaseFirestore.instance;
    final doc = await db.collection(usersCollection).doc(firebase.FirebaseAuth.instance.currentUser?.uid).get();
    User.instance.fromFirestore(doc.data());
  }

  static Future<List<Notification>> fetchNotifications() async {
    final db = FirebaseFirestore.instance;
    final notificationsSnapshot = await db.collection(notificationsCollection).get();
    print("notifications: ${notificationsSnapshot.docs}");
    final notifications = notificationsSnapshot.docs.map((e) => Notification.fromFirestore(e.data())).toList();
    return notifications;
  }

  static Future<void> logoutUser() async {}

  ///Events
  static Future<void> createEvent(Event event) async {
    final db = FirebaseFirestore.instance;
    final eventMap = event.toMap();
    final result = await db.collection(eventsCollection).add(eventMap);
    print(result);
  }

  static Future<List<Event>> fetchEvents() async {
    final db = FirebaseFirestore.instance;
    final eventsSnapshot = await db.collection(eventsCollection).orderBy('created_at', descending: true).get();
    final events = eventsSnapshot.docs.map((e) => Event.fromFirestore(e.data())).toList();
    return events;
  }

  static Future<List<User>> fetchPotentialCandidates(Event event) async {
    print('heree');
    final db = FirebaseFirestore.instance;

    // Fetch all users
    final usersSnapshot = await db.collection('users').get();
    print(usersSnapshot.docs);

    print('heree x3');
    // Use a set to eliminate duplicates
    final potentialCandidates = usersSnapshot.docs
        .map((doc) => User().fromFirestore(doc.data()))
        .where((user) {
          print('heree x2');
          // Check if user has matching skills
          final matchingSkills = user.skills?.entries
                  .where((entry) => entry.value) // Get skills the user has
                  .map((entry) => entry.key)
                  .toSet() ??
              {};

          print('heree x4: $matchingSkills');
          final requiredSkillsSet = event.requiredSkills.toSet();
          print('heree x5: $requiredSkillsSet');
          final hasRequiredSkills = requiredSkillsSet.intersection(matchingSkills).isNotEmpty;

          print('heree x6: $hasRequiredSkills');

          // Check if user is available for the event dates
          final isAvailable = user.availabilityDates?.any((date) =>
                  event.startDate != null &&
                  event.endDate != null &&
                  (date.isAtSameMomentAs(event.startDate!) || date.isAfter(event.startDate!)) &&
                  (date.isAtSameMomentAs(event.endDate!) || date.isBefore(event.endDate!))) ??
              false;
          print('heree x7: $isAvailable');

          return hasRequiredSkills && isAvailable;
        })
        .toSet() // Convert to a set to remove duplicates
        .toList(); // Convert back to a list

    print('heree');

    print("potentialCandidates: $potentialCandidates");

    return potentialCandidates;
  }

  // Fetch volunteer history
  static Future<List<Event>> fetchVolunteerHistory() async {
    final db = FirebaseFirestore.instance;
    print("uid: ${firebase.FirebaseAuth.instance.currentUser?.uid}");
    final eventsSnapshot = await db.collection(eventsCollection).where('volunteers', arrayContains: firebase.FirebaseAuth.instance.currentUser?.uid).get();
    print("doscsss: ${eventsSnapshot.docs}");
    final events = eventsSnapshot.docs.map((e) => Event.fromFirestore(e.data())).toList();
    return events;
  }
}
