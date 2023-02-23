import 'package:e_rejestr/dialogs/select_patient/patient_header_item.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/view_models/patient_create_view_model.dart';
import 'package:e_rejestr/widgets/patient_creat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientListItem extends StatefulWidget {
  const PatientListItem(this._patient, {required this.refresh, super.key});

  final Patient _patient;
  final VoidCallback refresh;
  @override
  State<PatientListItem> createState() => _PatientListItemState();
}

class _PatientListItemState extends State<PatientListItem> {
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
              PatientHeaderItem(widget._patient.firstName),
              PatientHeaderItem(widget._patient.lastName),
              PatientHeaderItem(widget._patient.getDocument()),
              PatientHeaderItem(widget._patient.residentialAddress.toString()),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, widget._patient);
                      },
                      child: const Text('Wybierz'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog<Patient>(
                          context: context,
                          builder: (context) => ChangeNotifierProvider(
                            create: (_) => PatientCreateViewModel(context, uid: widget._patient.uid),
                            child: Dialog(
                              child: Container(
                                color: lightPurple,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: const PatientCreate(),
                              ),
                            ),
                          ),
                        ).then((value) => widget.refresh());
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
