import 'package:e_rejestr/dialogs/select_patient/select_patient.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/view_models/patient_create_view_model.dart';
import 'package:e_rejestr/widgets/patient_creat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PsychologistMenu extends StatelessWidget {
  const PsychologistMenu(this.setPatient, {super.key});

  final Function(Patient patient) setPatient;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog<Patient?>(
              context: context,
              builder: (BuildContext context) {
                return SelectPatient();
              },
            ).then((value) {
              if (value != null) {
                setPatient(value);
              }
            });
          },
          child: const Text('Wybierz z bazy'),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog<Patient>(
              context: context,
              builder: (context) => ChangeNotifierProvider(
                create: (_) => PatientCreateViewModel(context),
                child: Dialog(
                  child: Container(
                    color: lightPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: const PatientCreate(),
                  ),
                ),
              ),
            ).then((value) {
              if (value != null) {
                setPatient(value);
              }
            });
          },
          child: const Text('Dodaj nowego pacjenta'),
        ),
      ],
    );
  }
}
