import 'package:flutter/material.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class Username {
  static String validate(String value) {
    return value.isEmpty ? 'Username can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    if (value.isEmpty) return 'Password can\'t be empty';
    if (value.length < 6)
      return 'Password too short. Password should contain six characters or more';
    return null;
  }
}

class Validity {}

enum FormType { login, register }
