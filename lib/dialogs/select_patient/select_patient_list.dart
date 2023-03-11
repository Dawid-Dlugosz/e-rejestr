import 'package:e_rejestr/dialogs/select_patient/patient_header_item.dart';
import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/widgets/empty_widget.dart';
import 'package:e_rejestr/widgets/patient_list/patient_list.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

class SelectPatientList extends StatefulWidget {
  const SelectPatientList(this.changePage, {super.key});

  final Function(bool value) changePage;

  @override
  State<SelectPatientList> createState() => _SelectPatientListState();
}

class _SelectPatientListState extends State<SelectPatientList> {
  var lastNameSearch = '';

  // function to refresh state of stream builder. Idn why stram is not refresh after edit user
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    lastNameSearch = value;
                  });
                },
                decoration: const InputDecoration(
                  label: Text('Wyszukaj po nazwisku'),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                widget.changePage(true);
              },
              child: const Text(
                'Dodaj nowego pacjenta',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
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
                  PatientHeaderItem('Imię'),
                  PatientHeaderItem('Nazwisko'),
                  PatientHeaderItem('Pesel / Inny dokument'),
                  PatientHeaderItem('Adres'),
                  PatientHeaderItem('Akcja'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: StreamBuilder<List<Document>>(
            stream: Firestore.instance.collection(Collection.patients.name).where('lastName', isGreaterThanOrEqualTo: lastNameSearch).orderBy('lastName').get().asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
                return PatientList(
                  snapshot.data!,
                  refresh: refresh,
                );
              } else {
                return const EmptyWidget();
              }
            },
          ),
        ),
      ],
    );
  }
}
