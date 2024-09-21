import 'package:cosc4353_volunteer_app/screens/notifications_screen.dart';
import 'package:cosc4353_volunteer_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  static const String id = 'create_event_screen';
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}
class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>['High'];
    const List<String> listTwo = <String>['Problem-solving, Teamwork, ...'];
    String dropdownValue = list.first;
    String dropdownValueTwo = listTwo.first;
    return Scaffold(
      appBar: AppBar(
        title: Text("New Event"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: const [
                  Icon(Icons.info_outline, size: 12),
                  SizedBox(width: 4),
                  Text("Only administrators can access this screen"),
                ],
              ),
              SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Event Name*',
                  counterText: '0/100',
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Event Description*',
                  counterText: '0/500',
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Location*',
                ),
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Required skills*'),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<String>(
                      value: dropdownValueTwo,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      onChanged: (String? value) =>
                          setState(() => dropdownValueTwo = value!),
                      items: listTwo
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Urgency*'),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      onChanged: (String? value) =>
                          setState(() => dropdownValue = value!),
                      items: list
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Event Date',
                ),
              ),
              SizedBox(height: 42),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, NotificationsScreen.id),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                child: Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

