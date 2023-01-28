import 'package:firedart/auth/user_gateway.dart';

class User {
  User({required this.login, required this.password});

  final String login;
  final String password;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(login: json['login'], password: json['password']);
  }
}
