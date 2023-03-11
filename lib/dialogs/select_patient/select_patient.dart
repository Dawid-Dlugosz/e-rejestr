import 'package:e_rejestr/dialogs/select_patient/select_patient_list.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/view_models/patient_create_view_model.dart';
import 'package:e_rejestr/widgets/patient_creat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectPatient extends StatefulWidget {
  const SelectPatient({super.key});

  @override
  State<SelectPatient> createState() => _SelectPatientState();
}

class _SelectPatientState extends State<SelectPatient> {
  bool createUser = false;

  void changeScreen(bool value) {
    setState(() {
      createUser = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        color: lightPurple,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: createUser ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width,
        child: !createUser ? SelectPatientList(changeScreen) : ChangeNotifierProvider(create: (context) => PatientCreateViewModel(context), child: PatientCreate(changeScreen: changeScreen)),
      ),
    );
  }
}
