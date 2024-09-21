import 'package:flutter/material.dart';

class VolunteerMatchingScreen extends StatelessWidget {
  static const String id = 'volunteer_matching_screen';
  const VolunteerMatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Matching'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline, size: 12),
                    SizedBox(width: 4),
                    Text("Only administrators can access this screen"),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text('Potential matches',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ),
                    Flexible(
                      child: ListView.builder(
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Candidate Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text("Address"),
                                  Text("State"),
                                  Text("Zip code"),
                                  Text("Skills"),
                                  Text("Preferences"),
                                  Text("Availability"),
                                  Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Colors.green,
                                          child: Icon(Icons.check,
                                              color: Colors.white),
                                        ),
                                        SizedBox(width: 24),
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundColor: Colors.red,
                                          child: Icon(Icons.close,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Expanded(
                    //   child: Container(
                    //     margin:
                    //         EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12),
                    //       color: Colors.grey[300],
                    //     ),
                    //     padding: EdgeInsets.all(32),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.stretch,
                    //       children: [
                    //         CircleAvatar(
                    //           radius: 32,
                    //           backgroundColor: Colors.deepOrange[400],
                    //           child: Text("AA"),
                    //         ),
                    //       ],
                    //     ),
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
