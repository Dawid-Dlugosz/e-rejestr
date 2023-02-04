import 'package:e_rejestr/dialogs/select_patient/patient_header_item.dart';
import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/widgets/empty_widget.dart';
import 'package:e_rejestr/widgets/patient_list/patient_list.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

class SelectPatientList extends StatelessWidget {
  const SelectPatientList(this.changePage, {super.key});

  final Function(bool value) changePage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: const TextField(
                decoration: InputDecoration(
                  label: Text('Wyszukaj po nazwisku'),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                changePage(true);
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
        Row(
          children: const [
            PatientHeaderItem('Imię'),
            PatientHeaderItem('Nazwisko'),
            PatientHeaderItem('Pesel / Inny dokument'),
            PatientHeaderItem('Adres'),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: StreamBuilder<List<Document>>(
            stream: Firestore.instance.collection(Collection.patients.name).stream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
                return PatientList(snapshot.data!);
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
