import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'package:kanban_board/constants.dart';

class Login {
  String _username;
  String _password;
  bool _isUsernameValid = false;
  bool _isPasswordValid = false;
  String _token;

  String getToken() => _token;

  String checkUsername(String username) {
    _username = username;
    if (_username.length < 4) {
      _isUsernameValid = false;
      if (_username.length == 0) {
        return null;
      }
      return 'Minimum length is 4 characters';
    }
    _isUsernameValid = true;
    return null;
  }

  String checkPassword(String password) {
    _password = password;
    if (_password.length < 8) {
      _isPasswordValid = false;
      if (_password.length == 0) {
        return null;
      }
      return 'Minimum length is 8 characters';
    }
    _isPasswordValid = true;
    return null;
  }

  bool canSubmit() => _isUsernameValid && _isPasswordValid;

  Future<String> submitForm() async {
    var response = await http.post('$kApiString/users/login/', body: {
      'username': _username,
      'password': _password,
    });
    final Map body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      _token = body['token'];
      return null;
    }
    return body.containsKey('non_field_errors')
        ? body['non_field_errors'][0]
        : body.toString();
  }
}
