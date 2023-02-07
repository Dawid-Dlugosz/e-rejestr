import 'package:e_rejestr/dialogs/select_patient/patient_header_item.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';

class PatientListItem extends StatelessWidget {
  const PatientListItem(this._patient, {super.key});

  final Patient _patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: Table(
        border: TableBorder.all(color: white, style: BorderStyle.solid, width: 2),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FractionColumnWidth(0.02),
          1: FractionColumnWidth(0.07),
          2: FractionColumnWidth(0.18),
          3: FractionColumnWidth(0.1),
          4: FractionColumnWidth(0.07),
        },
        children: [
          TableRow(
            children: [
              PatientHeaderItem(_patient.firstName),
              PatientHeaderItem(_patient.lastName),
              PatientHeaderItem(_patient.getDocument()),
              PatientHeaderItem(_patient.residentialAddress.toString()),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, _patient);
                      },
                      child: const Text('Wybierz'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO MAKE EDIT PATIENT
                      },
                      child: const Text('Edytuj'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
