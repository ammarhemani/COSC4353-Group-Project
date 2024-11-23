import 'package:cosc4353_volunteer_app/blocs/volunteer_history/volunteer_history_bloc.dart';
import 'package:cosc4353_volunteer_app/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VolunteerHistoryScreen extends StatefulWidget {
  static const String id = 'volunteer_history_screen';
  const VolunteerHistoryScreen({super.key});

  @override
  State<VolunteerHistoryScreen> createState() => _VolunteerHistoryScreenState();
}

class _VolunteerHistoryScreenState extends State<VolunteerHistoryScreen> {
  final VolunteerHistoryBloc _volunteerHistoryBloc = VolunteerHistoryBloc();

  @override
  void initState() {
    super.initState();
    _volunteerHistoryBloc.add(FetchVolunteerHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Volunteer History")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<VolunteerHistoryBloc, VolunteerHistoryState>(
            bloc: _volunteerHistoryBloc,
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is VolunteerHistoryLoading) Center(child: CircularProgressIndicator()),
                    if (state is VolunteerHistoryLoaded) ...[
                      // Upcoming Section
                      if (state.events.any((event) => event.startDate!.isAfter(DateTime.now()))) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 8),
                          child: Text("Upcoming", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                        ListView.builder(
                          itemCount: state.events.where((event) => event.startDate!.isAfter(DateTime.now())).length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final upcomingEvents = state.events.where((event) => event.startDate!.isAfter(DateTime.now())).toList();
                            return EventCard(event: upcomingEvents[index]);
                          },
                        ),
                      ],
                      SizedBox(height: 24),
                      // History Section
                      if (state.events.any((event) => event.startDate!.isBefore(DateTime.now()))) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 8),
                          child: Text("History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                        ListView.builder(
                          itemCount: state.events.where((event) => event.startDate!.isBefore(DateTime.now())).length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final pastEvents = state.events.where((event) => event.startDate!.isBefore(DateTime.now())).toList();
                            return EventCard(event: pastEvents[index]);
                          },
                        ),
                      ],
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
