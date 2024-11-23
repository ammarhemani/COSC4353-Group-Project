import 'package:cosc4353_volunteer_app/models/event.dart';
import 'package:cosc4353_volunteer_app/models/user.dart';
import 'package:cosc4353_volunteer_app/screens/volunteer_matching_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (User.instance.userType == UserType.administrator) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VolunteerMatchingScreen(event: event)));
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    event.name ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (event.startDate != null && event.endDate != null)
                    Text(
                      "${DateFormat('MM/dd/yyyy').format(event.startDate!)} - ${DateFormat('MM/dd/yyyy').format(event.endDate!)}",
                      style: TextStyle(fontSize: 10),
                    ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.pin_drop_outlined, size: 20),
                  Text(event.location ?? ""),
                ],
              ),
              SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Required skills: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: event.requiredSkills.join(", ")),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Urgency: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: event.urgency ?? ""),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Text(event.description ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
