import 'package:e_rejestr/screens/medical_register.dart';
import 'package:e_rejestr/screens/new_judgment.dart';
import 'package:e_rejestr/screens/psychological_register.dart';
import 'package:e_rejestr/utils/pages.dart';
import 'package:e_rejestr/view_models/new_judgment_creator_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuContainer extends StatelessWidget {
  const MenuContainer(this.number, {super.key});
  final int number;
  @override
  Widget build(BuildContext context) {
    switch (number) {
      case medicalRegister:
        return const MedicalRegister();
      case psychologicalRegister:
        return const PsychologicalRegister();
      case newJudgment:
        return ChangeNotifierProvider(
          create: (_) => NewJudgmentCreatorViewModel(),
          child: const NewJudgmentCreator(),
        );
      default:
        return Container();
    }
  }
}
