import 'package:cosc4353_volunteer_app/blocs/events/events_bloc.dart';
import 'package:cosc4353_volunteer_app/screens/create_event_screen.dart';
import 'package:cosc4353_volunteer_app/services/report_generator.dart';
import 'package:cosc4353_volunteer_app/widgets/administrator_view_widget.dart';
import 'package:cosc4353_volunteer_app/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsScreen extends StatefulWidget {
  static const String id = 'events_screen';
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final EventsBloc _eventsBloc = EventsBloc();

  @override
  void initState() {
    super.initState();
    _eventsBloc.add(FetchEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEventScreen(eventsBloc: _eventsBloc))),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.ios_share),
            onSelected: (String format) {
              ReportGenerator.shareReport(format);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'pdf',
                child: Text('Export as PDF'),
              ),
              const PopupMenuItem<String>(
                value: 'csv',
                child: Text('Export as CSV'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: BlocBuilder<EventsBloc, EventsState>(
              bloc: _eventsBloc,
              builder: (context, state) {
                return Column(
                  children: [
                    AdministratorViewWidget(),
                    const SizedBox(height: 12),
                    if (state is EventsLoading) const Center(child: CircularProgressIndicator()),
                    if (state is EventsLoaded)
                      ListView.builder(
                        itemCount: state.events.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) => EventCard(event: state.events[index]),
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
