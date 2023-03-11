
import 'package:e_rejestr/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel() {
    _init();
  }

  bool loaded = false;
  late String filePath;

  Future<void> _init() async {
    filePath = await getFilePath();
    loaded = true;
    notifyListeners();
  }

  Future<void> changeFielPaht() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory != null) {
      filePath = selectedDirectory;
      await saveFilePath(selectedDirectory);
      notifyListeners();
    }
  }
}
