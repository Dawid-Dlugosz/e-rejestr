import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/view_models/psychologist_card_view_model.dart';
import 'package:e_rejestr/view_models/medical_register_view_model.dart';
import 'package:e_rejestr/widgets/psychological_register.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PatientInfo extends StatelessWidget {
  const PatientInfo(this.patient, {super.key});
  final Patient? patient;

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);

    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<String>(
            future: Provider.of<MedicalRegisterViewModel>(context, listen: false).getRegisterNumbre(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Text(
                  'Nr. rej. : ${snapshot.data!}',
                  style: const TextStyle(color: white, fontSize: 30),
                );
              }
              return const Text(
                'Nr. rej. :',
                style: TextStyle(color: white, fontSize: 30),
              );
            },
          ),
          Text(
            'Imię i Nazwisko: ${patient != null ? patient!.getFullName() : ''}',
            style: const TextStyle(color: white, fontSize: 30),
          ),
          Text(
            'Data urodzenia: ${patient != null ? patient!.birthday : ''}',
            style: const TextStyle(color: white, fontSize: 30),
          ),
          Text(
            'PESEL / nr. dokumentu: ${patient != null ? patient!.getDocument() : ''}',
            style: const TextStyle(color: white, fontSize: 30),
          ),
          Text(
            'Ades: ${patient != null ? patient!.residentialAddress.toString() : ''}',
            style: const TextStyle(color: white, fontSize: 30),
          ),
          Text(
            'Data badania: $formattedDate',
            style: const TextStyle(color: white, fontSize: 30),
          ),
        ],
      ),
    );
  }
}
