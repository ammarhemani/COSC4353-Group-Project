part of 'volunteer_history_bloc.dart';

@immutable
abstract class VolunteerHistoryState {
  const VolunteerHistoryState();
}

class VolunteerHistoryInitial extends VolunteerHistoryState {}

class VolunteerHistoryLoading extends VolunteerHistoryState {}

class VolunteerHistoryLoaded extends VolunteerHistoryState {
  final List<Event> events;
  const VolunteerHistoryLoaded(this.events);
}

class VolunteerHistoryError extends VolunteerHistoryState {}
