part of 'events_bloc.dart';

@immutable
abstract class EventsState {
  const EventsState();
}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final List<Event> events;
  const EventsLoaded(this.events);
}

class EventsError extends EventsState {}
