part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {
  const ProfileEvent();
}

class UpdateProfile extends ProfileEvent {
  final User updatedUserObj;
  const UpdateProfile({required this.updatedUserObj});
}
