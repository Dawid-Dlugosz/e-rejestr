import 'package:e_rejestr/screens/login.dart';
import 'package:e_rejestr/utils/firestore.dart';
import 'package:firedart/auth/exceptions.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this.context) {
    _init();
  }

  final BuildContext context;

  bool loaded = false;
  bool loginLoading = false;

  Future<void> _init() async {
    loaded = true;
    notifyListeners();
  }

  void login({required String login, required String password}) {
    loginLoading = true;
    notifyListeners();
    try {
      FirebaseAuth.instance.signIn(login, password);
    } on AuthException catch (e) {
      showSnackBar(e.errorCode, context);
    }
  }
}
