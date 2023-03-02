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
