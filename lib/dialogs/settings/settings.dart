import 'package:e_rejestr/dialogs/settings/file_path.dart';
import 'package:e_rejestr/dialogs/settings/text_field_number.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/view_models/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (_, viewModel, __) {
        return viewModel.loaded
            ? Dialog(
                backgroundColor: lightPurple,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FilePath(
                          filePath: viewModel.filePath,
                          changeFielPaht: viewModel.changeFielPaht,
                        ),
                        const Padding(padding: EdgeInsets.all(8), child: Divider()),
                        const Text(
                          'Numery orzeczeń:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: white),
                        ),
                        TextFieldNumber(
                          text: 'Numer orzeczenia lekarskiego',
                          hint: '1/2/23',
                          editingController: viewModel.medicalEditingController,
                          change: viewModel.changeMedicalNumber,
                        ),
                        TextFieldNumber(
                          text: 'Numer orzeczenia psychologicznego',
                          hint: '1/2/23',
                          editingController: viewModel.psychoEditingController,
                          change: viewModel.changePsychoNumber,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
