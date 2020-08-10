import 'package:flutter/material.dart';
import 'package:kanban_board/constants.dart';
import 'package:kanban_board/widgets/login_form_field.dart';
import 'package:kanban_board/cubits/login/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kanban'),
        backgroundColor: Colors.black12,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (prevState, state) {
                if (state is PasswordError ||
                    (state is UsernameError &&
                        prevState is UsernameError &&
                        prevState.error == state.error)) {
                  return false;
                }
                return true;
              },
              builder: (context, state) =>
                  buildUsernameField(context, state.error),
            ),
            SizedBox(height: 20),
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (prevState, state) {
                if (state is UsernameError ||
                    (state is PasswordError &&
                        prevState is PasswordError &&
                        prevState.error == state.error)) {
                  return false;
                }
                return true;
              },
              builder: (context, state) =>
                  buildPasswordField(context, state.error),
            ),
            SizedBox(height: 30),
            GestureDetector(
              child: Container(
                width: double.infinity,
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kFocusedColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'login'.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45,
                  ),
                ),
              ),
              onTap: () async {
                context.bloc<LoginCubit>().trySubmitting(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  LoginFormField buildUsernameField(BuildContext context, String error) {
    return LoginFormField(
      hintText: 'username_hint'.tr(),
      errorText: error,
      onChanged: (username) {
        context.bloc<LoginCubit>().checkUsername(username);
      },
    );
  }

  LoginFormField buildPasswordField(BuildContext context, String error) {
    return LoginFormField(
      hintText: 'password_hint'.tr(),
      errorText: error,
      isPassword: true,
      onChanged: (password) {
        context.bloc<LoginCubit>().checkPassword(password);
      },
    );
  }
}
