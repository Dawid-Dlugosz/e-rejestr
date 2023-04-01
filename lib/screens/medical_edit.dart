import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/models/register.dart';
import 'package:e_rejestr/widgets/patient_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MedicalEdit extends StatefulWidget {
  const MedicalEdit({required this.register, super.key});
  final Register register;

  @override
  State<MedicalEdit> createState() => _MedicalEditState();
}

class _MedicalEditState extends State<MedicalEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edytuj orzeczenie lekarskie'),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: Patient.getPatientByKartNumber(number: widget.register.getNumberWithOutAlpha(), documentType: DocumentType.medical),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return PatientInfo(
                  snapshot.data!,
                  hideRegisters: true,
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
