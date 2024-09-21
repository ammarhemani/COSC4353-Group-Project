import 'package:flutter/material.dart';

class VolunteerHistoryScreen extends StatelessWidget {
  static const String id = 'volunteer_history_screen';
  const VolunteerHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Volunteer History"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 12,
                padding: EdgeInsets.all(12),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Event Name",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Event date: 09/16/2024",
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.pin_drop_outlined, size: 20),
                              Text("Event location"),
                            ],
                          ),
                          Text("Event Description"),
                          Text("Required skills: Lorem ipsum"),
                          Text("Urgency: high"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
