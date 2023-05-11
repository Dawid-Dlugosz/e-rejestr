import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/widgets/patient_list/patient_list_item.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';

class PatientList extends StatelessWidget {
  const PatientList(
    this.list, {
    required this.refresh,
    super.key,
  });
  final List<Document> list;
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FractionColumnWidth(0.02),
            1: FractionColumnWidth(0.07),
            2: FractionColumnWidth(0.18),
            3: FractionColumnWidth(0.1),
          },
          children: [
            ...list
                .map(
                  (e) => TableRow(
                    children: [
                      PatientListItem(
                        Patient.fromJson(e.map),
                        refresh: refresh,
                      ),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
