import 'package:e_rejestr/dialogs/add_firm.dart';
import 'package:e_rejestr/dialogs/select_patient/patient_header_item.dart';
import 'package:e_rejestr/models/firm.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/view_models/firm_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirmListItem extends StatelessWidget {
  const FirmListItem(this.firm, {super.key});

  final Firm firm;

  @override
  Widget build(BuildContext context) {
    var firmViewModel = Provider.of<FirmViewModel>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: Table(
        border: TableBorder.all(color: white, style: BorderStyle.solid, width: 2),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FractionColumnWidth(0.1),
          1: FractionColumnWidth(0.1),
          2: FractionColumnWidth(0.18),
          3: FractionColumnWidth(0.18),
        },
        children: [
          TableRow(
            children: [
              PatientHeaderItem(firm.nip),
              PatientHeaderItem(firm.name),
              PatientHeaderItem(firm.address),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, firm);
                      },
                      child: const Text('Wybierz'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AddFirm(
                              firmViewModel,
                              firm: firm,
                            );
                          },
                        ).then((value) => firmViewModel.createFirmList());
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
