part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  final String error;
  LoginState([this.error]);
}

class LoginInitial extends LoginState {}

class UsernameError extends LoginState {
  final String error;
  UsernameError(this.error);
}

class PasswordError extends LoginState {
  final String error;
  PasswordError(this.error);
}
