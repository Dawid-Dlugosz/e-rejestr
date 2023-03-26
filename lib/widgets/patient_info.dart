import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/view_models/register_view_model.dart';
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<String>(
                future: Provider.of<RegisterViewModel>(context, listen: false).getPsychoRegisterNumber(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Text(
                      'Nr. rej. psycho : ${snapshot.data!}',
                      style: const TextStyle(color: white, fontSize: 25),
                    );
                  }
                  return const Text(
                    'Nr. rej. psycho :',
                    style: TextStyle(color: white, fontSize: 25),
                  );
                },
              ),
              FutureBuilder<String>(
                future: Provider.of<RegisterViewModel>(context, listen: false).getRegisterMedicalNumber(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Text(
                      'Nr. rej. lekarskiego : ${snapshot.data!}',
                      style: const TextStyle(color: white, fontSize: 25),
                    );
                  }
                  return const Text(
                    'Nr. rej. lekarskiego :',
                    style: TextStyle(color: white, fontSize: 25),
                  );
                },
              ),
            ],
          ),
          Text(
            'Imię i Nazwisko: ${patient != null ? patient!.getFullName() : ''}',
            style: const TextStyle(color: white, fontSize: 25),
          ),
          Text(
            'Data urodzenia: ${patient != null ? patient!.birthday : ''}',
            style: const TextStyle(color: white, fontSize: 25),
          ),
          Text(
            'PESEL / nr. dokumentu: ${patient != null ? patient!.getDocument() : ''}',
            style: const TextStyle(color: white, fontSize: 25),
          ),
          Text(
            'Ades: ${patient != null ? patient!.residentialAddress.toString() : ''}',
            style: const TextStyle(color: white, fontSize: 25),
          ),
          Text(
            'Data badania: $formattedDate',
            style: const TextStyle(color: white, fontSize: 25),
          ),
        ],
      ),
    );
  }
}
