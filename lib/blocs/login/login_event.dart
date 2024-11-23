part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class FormSubmitted extends LoginEvent {
  final String email;
  final String password;
  const FormSubmitted({required this.email, required this.password});
}
