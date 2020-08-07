import 'package:flutter/material.dart';
import 'package:kanban_board/constants.dart';
import 'package:kanban_board/widgets/login_form_field.dart';
import 'package:kanban_board/cubits/login/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String oldUsernameError;
    String oldPasswordError;

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
              builder: (context, state) {
                if (state is UsernameError) {
                  oldUsernameError = state.error;
                  return buildUsernameField(context, state.error);
                }
                return buildUsernameField(context, oldUsernameError);
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state is PasswordError) {
                  oldPasswordError = state.error;
                  return buildPasswordField(context, state.error);
                }
                return buildPasswordField(context, oldPasswordError);
              },
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
                  'Log in',
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
      hintText: 'Enter your username',
      errorText: error,
      onChanged: (username) {
        context.bloc<LoginCubit>().checkUsername(username);
      },
    );
  }

  LoginFormField buildPasswordField(BuildContext context, String error) {
    return LoginFormField(
      hintText: 'Enter your password',
      errorText: error,
      isPassword: true,
      onChanged: (password) {
        context.bloc<LoginCubit>().checkPassword(password);
      },
    );
  }
}
