import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/widgets/patient_list/patient_list_item.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';

class PatientList extends StatelessWidget {
  const PatientList(this.list, {super.key});
  final List<Document> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        var patient = Patient.fromJson(list[index].map);
        return PatientListItem(patient);
      },
    );
  }
}
