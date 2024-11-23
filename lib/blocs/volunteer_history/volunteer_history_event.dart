part of 'volunteer_history_bloc.dart';

@immutable
abstract class VolunteerHistoryEvent {
  const VolunteerHistoryEvent();
}

class FetchVolunteerHistory extends VolunteerHistoryEvent {}
