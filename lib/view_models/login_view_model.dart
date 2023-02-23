import 'dart:convert';

import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/models/user.dart';
import 'package:e_rejestr/screens/home/home.dart';
import 'package:e_rejestr/utils/firestore.dart';
import 'package:e_rejestr/utils/shared_preferences.dart';
import 'package:e_rejestr/view_models/home_view_model.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this.context) {
    _init();
  }

  final BuildContext context;

  bool loaded = false;
  bool showWrongPassword = true;
  Future<void> _init() async {
    loaded = true;
    notifyListeners();
  }

  Future<void> login({required String login, required String password}) async {
    loaded = true;
    notifyListeners();

    var passwordUtf = utf8.encode(password);
    var passwordHash = sha256.convert(passwordUtf);

    var reference = await Firestore.instance.collection(Collection.users.name).where('login', isEqualTo: login).get();

    if (reference.isEmpty) {
      if (!context.mounted) return;
      showSnackBar(userNotFound, context);
      loaded = false;
      notifyListeners();
      return;
    }

    reference.forEach((element) {
      var user = User.fromJson(element.map);
      if (user.password == passwordHash.toString()) {
        int timestamp = DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;

        showWrongPassword = false;
        loaded = false;
        notifyListeners();

        saveSession(timestamp);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => HomeViewModel(),
              child: const Home(),
            ),
          ),
        );

        return;
      }
    });

    if (!context.mounted) return;
    if (showWrongPassword) {
      showSnackBar(wrongPassword, context);
    }

    loaded = false;
    notifyListeners();
  }
}
