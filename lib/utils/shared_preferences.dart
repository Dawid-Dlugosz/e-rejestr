import 'package:e_rejestr/enums/preferences.dart';
import 'package:e_rejestr/models/judgment_number.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveSession(int timeStamp) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(Preferences.session.name, timeStamp);
}

Future<int?> getSession() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(Preferences.session.name);
}

Future<bool> resetSession() async {
  final prefs = await SharedPreferences.getInstance();
  return await prefs.remove(Preferences.session.name);
}

Future<JudgmentNumber> getPsychoJudgmentNumber() async {
  final prefs = await SharedPreferences.getInstance();
  var number = await prefs.getString(Preferences.psychoNumber.name);
  if (number == null) {
    var year = DateTime.now().year.toString().substring(DateTime.now().year.toString().length - 2);
    return JudgmentNumber(personNo: '1', month: DateTime.now().month, year: year);
  } else {
    var numbers = number.split('/');
    return JudgmentNumber(personNo: numbers[0], month: int.parse(numbers[1]), year: numbers[2]);
  }
}
