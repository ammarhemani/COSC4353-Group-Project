part of 'volunteer_matching_bloc.dart';

@immutable
abstract class VolunteerMatchingEvent {
  const VolunteerMatchingEvent();
}

class FetchPotentialCandidates extends VolunteerMatchingEvent {
  final Event event;
  const FetchPotentialCandidates(this.event);
}
