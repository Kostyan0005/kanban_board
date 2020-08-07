import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:kanban_board/models/login.dart';
import 'package:kanban_board/screens/board_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Login _login;

  LoginCubit(this._login) : super(LoginInitial());

  void checkUsername(String username) {
    emit(UsernameError(_login.checkUsername(username)));
  }

  void checkPassword(String password) {
    emit(PasswordError(_login.checkPassword(password)));
  }

  Future<void> trySubmitting(BuildContext context) async {
    if (_login.canSubmit()) {
      final error = await _login.submitForm();
      if (error == null) {
        Navigator.popAndPushNamed(context, '/board',
            arguments: BoardScreenArgs(_login.getToken()));
      } else {
        emit(PasswordError(error));
      }
    }
  }
}
