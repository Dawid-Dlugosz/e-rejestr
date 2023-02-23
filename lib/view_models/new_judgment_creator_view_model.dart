import 'package:flutter/material.dart';

class NewJudgmentCreatorViewModel extends ChangeNotifier {
  NewJudgmentCreatorViewModel() {
    _init();
  }

  bool loaded = false;
  final List<String> psychologistJudgments = [
    'Ogólny',
    'Przedłużenie',
    '39',
    'Uprzywilej',
    'Alkohol',
    'Punkty karne',
    'Przywrócenie',
    'Wypadek',
  ];

  Future<void> _init() async {
    loaded = true;
    notifyListeners();
  }
}
