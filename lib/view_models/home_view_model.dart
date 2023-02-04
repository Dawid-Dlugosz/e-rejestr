import 'package:e_rejestr/utils/pages.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    _init();
  }

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
