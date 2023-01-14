import 'dart:core';

const String _emailRegex =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

String? emailValidator(emailInput) {
  if (emailInput == null ||
      emailInput.isEmpty ||
      !RegExp(_emailRegex).hasMatch(emailInput)) {
    return 'Enter a valid email address.';
  }
  return null;
}

String? passwordValidator(emailInput, passwordInput) {
  if (emailValidator(emailInput) != null &&
      (passwordInput == null || passwordInput.isEmpty)) {
    return 'Check your info and try again.';
  }
  return null;
}
