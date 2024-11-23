part of 'volunteer_matching_bloc.dart';

@immutable
abstract class VolunteerMatchingState {
  const VolunteerMatchingState();
}

class VolunteerMatchingInitial extends VolunteerMatchingState {}

class VolunteerMatchingLoading extends VolunteerMatchingState {}

class VolunteerMatchingLoaded extends VolunteerMatchingState {
  final List<User> candidates;
  const VolunteerMatchingLoaded(this.candidates);
}

class VolunteerMatchingError extends VolunteerMatchingState {}
