import 'package:cosc4353_volunteer_app/blocs/volunteer_matching/volunteer_matching_bloc.dart';
import 'package:cosc4353_volunteer_app/models/event.dart';
import 'package:cosc4353_volunteer_app/widgets/administrator_view_widget.dart';
import 'package:cosc4353_volunteer_app/widgets/candidate_card.dart';
import 'package:cosc4353_volunteer_app/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VolunteerMatchingScreen extends StatefulWidget {
  static const String id = 'volunteer_matching_screen';
  final Event event;
  const VolunteerMatchingScreen({super.key, required this.event});

  @override
  State<VolunteerMatchingScreen> createState() => _VolunteerMatchingScreenState();
}

class _VolunteerMatchingScreenState extends State<VolunteerMatchingScreen> {
  final VolunteerMatchingBloc _volunteerMatchingBloc = VolunteerMatchingBloc();

  @override
  void initState() {
    super.initState();
    _volunteerMatchingBloc.add(FetchPotentialCandidates(widget.event));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Volunteer Matching')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: BlocBuilder<VolunteerMatchingBloc, VolunteerMatchingState>(
              bloc: _volunteerMatchingBloc,
              builder: (context, state) {
                return Column(
                  children: [
                    AdministratorViewWidget(),
                    SizedBox(height: 12),
                    EventCard(event: widget.event),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text('Potential matches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        if (state is VolunteerMatchingLoading) Center(child: CircularProgressIndicator()),
                        if (state is VolunteerMatchingLoaded)
                          ListView.builder(
                            itemCount: state.candidates.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => CandidateCard(state.candidates[index]),
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
