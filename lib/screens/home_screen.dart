import 'package:cosc4353_volunteer_app/models/user.dart';
import 'package:cosc4353_volunteer_app/screens/events_screen.dart';
import 'package:cosc4353_volunteer_app/screens/notifications_screen.dart';
import 'package:cosc4353_volunteer_app/screens/profile_screen.dart';
import 'package:cosc4353_volunteer_app/screens/volunteer_history_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // To keep track of the selected tab

  // List of widgets corresponding to each tab
  List<Widget> _pages = [];
  List<BottomNavigationBarItem> _bottomNavigationBarItems = [];

  @override
  void initState() {
    super.initState();
    if (User.instance.userType == UserType.volunteer) {
      _pages = [
        VolunteerHistoryScreen(),
        NotificationsScreen(),
        ProfileScreen(),
      ];
      _bottomNavigationBarItems = [
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ];
    } else {
      _pages = [
        EventsScreen(),
        NotificationsScreen(),
        ProfileScreen(),
      ];
      _bottomNavigationBarItems = [
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ];
    }
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
