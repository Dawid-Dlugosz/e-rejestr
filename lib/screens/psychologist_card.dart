import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/utils/pages.dart';
import 'package:e_rejestr/widgets/my_app_bar.dart';
import 'package:e_rejestr/widgets/patient_info.dart';
import 'package:e_rejestr/widgets/psychologist_menu.dart';
import 'package:flutter/material.dart';

class PsychologistCard extends StatefulWidget {
  const PsychologistCard({super.key});

  @override
  State<PsychologistCard> createState() => _PsychologistCardState();
}

class _PsychologistCardState extends State<PsychologistCard> {
  Patient? patient;

  void setPatient(Patient patient) {
    setState(() {
      this.patient = patient;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBar(pageIndex: psychologistCard),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            PsychologistMenu(setPatient),
            Row(
              children: [
                PatientInfo(patient),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
