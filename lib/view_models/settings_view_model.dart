import 'package:e_rejestr/utils/shared_preferences.dart';
import 'package:e_rejestr/view_models/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel(this.context) {
    _init();
  }
  final BuildContext context;

  bool loaded = false;
  TextEditingController medicalEditingController = TextEditingController();
  TextEditingController psychoEditingController = TextEditingController();

  late String filePath;
  late RegisterViewModel registerViewModel;

  Future<void> _init() async {
    registerViewModel = Provider.of<RegisterViewModel>(context, listen: false);
    await _setEditingControllers();
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

  Future<void> _setEditingControllers() async {
    medicalEditingController.text = await registerViewModel.getRegisterMedicalNumber();
    psychoEditingController.text = await registerViewModel.getPsychoRegisterNumber();
    notifyListeners();
  }

  void changePsychoNumber() {
    registerViewModel.updatePsychoRegisterNumber(psychoEditingController.text);
    _showSnackBar();
  }

  void changeMedicalNumber() {
    registerViewModel.updateMedicalRegisterNumber(medicalEditingController.text);
    _showSnackBar();
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    var snackBar = const SnackBar(
      content: Text('Zmiany zostały zapisane'),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
