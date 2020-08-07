import 'package:flutter/material.dart';
import '../constants.dart';

class LoginFormField extends StatelessWidget {
  final String hintText;
  final String errorText;
  final Function onChanged;
  final bool isPassword;

  LoginFormField({
    @required this.hintText,
    @required this.errorText,
    @required this.onChanged,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: isPassword ? true : false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: kFocusedColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: kErrorColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
