part of 'events_bloc.dart';

@immutable
abstract class EventsEvent {
  const EventsEvent();
}

class CreateEvent extends EventsEvent {
  final Event event;
  const CreateEvent(this.event);
}

class FetchEvents extends EventsEvent {}
