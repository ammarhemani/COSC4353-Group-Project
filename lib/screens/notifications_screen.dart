import 'package:cosc4353_volunteer_app/blocs/notifications/notifications_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatefulWidget {
  static const String id = 'notifications_screen';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationsBloc notificationsBloc = NotificationsBloc();
  @override
  void initState() {
    super.initState();
    notificationsBloc.add(FetchNotificationsData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<NotificationsBloc, NotificationsState>(
                bloc: notificationsBloc,
                builder: (context, state) {
                  if (state is NotificationsLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is NotificationsLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.notifications.length,
                        padding: EdgeInsets.all(12),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.notifications[index].title ?? "",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        state.notifications[index].timestamp?.toString() ?? "",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    state.notifications[index].subtitle ?? "",
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
