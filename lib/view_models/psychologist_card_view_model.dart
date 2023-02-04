import 'package:flutter/material.dart';

class PsychologistCardViewModel extends ChangeNotifier {
  PsychologistCardViewModel() {
    _init();
  }

  bool loaded = false;

  Future<void> _init() async {
    loaded = true;
    notifyListeners();
  }
}
