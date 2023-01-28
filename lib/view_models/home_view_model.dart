import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    _init();
  }
  static const medicalRegister = 0;
  static const psychologicalRegister = 1;

  static bool loaded = false;

  // what is show on right site in homePage
  int initialRegisterPage = medicalRegister;

  Future<void> _init() async {
    loaded = true;
    notifyListeners();
  }

  void changeScreenRecord(int record) {
    initialRegisterPage = record;
    notifyListeners();
  }
}
