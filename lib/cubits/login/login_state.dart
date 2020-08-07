part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class UsernameError extends LoginState {
  final String error;
  UsernameError(this.error);
}

class PasswordError extends LoginState {
  final String error;
  PasswordError(this.error);
}
