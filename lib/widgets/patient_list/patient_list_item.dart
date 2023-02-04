import 'package:e_rejestr/dialogs/select_patient/patient_header_item.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:flutter/material.dart';

class PatientListItem extends StatelessWidget {
  const PatientListItem(this._patient, {super.key});

  final Patient _patient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context, _patient),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            PatientHeaderItem(_patient.firstName),
            PatientHeaderItem(_patient.lastName),
            PatientHeaderItem(_patient.getDocument()),
            PatientHeaderItem(_patient.residentialAddress.toString()),
          ],
        ),
      ),
    );
  }
}
