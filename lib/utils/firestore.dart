import 'package:flutter/material.dart';

const invalidEmail = 'invalid-email';
const userDisabled = 'user-disabled';
const userNotFound = 'user-not-found';
const wrongPassword = 'wrong-password';

void showSnackBar(String errorCode, BuildContext context) {
  var snackBar = SnackBar(
    content: Text(errorCodeToText(errorCode)),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

String errorCodeToText(String errorCode) {
  switch (errorCode) {
    case invalidEmail:
      return 'Nieprawidłowy e-mail';
    case userDisabled:
      return 'Użytkownik zdezaktywowany';
    case userNotFound:
      return 'Nie znaleziono takiego użytkownika';
    case wrongPassword:
      return 'Błędne hasło';
    default:
      return errorCode;
  }
}
