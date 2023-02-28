import 'dart:math';

import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/pdf/karta_kz/p1_right_size.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/pages.dart';
import 'package:e_rejestr/view_models/new_judgment_creator_view_model.dart';
import 'package:e_rejestr/widgets/my_app_bar.dart';
import 'package:e_rejestr/widgets/patient_info.dart';
import 'package:e_rejestr/widgets/psychologist_menu.dart';
import 'package:e_rejestr/widgets/select_psychology/select_psychologist_judgment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewJudgmentCreator extends StatefulWidget {
  const NewJudgmentCreator({super.key});

  @override
  State<NewJudgmentCreator> createState() => _NewJudgmentCreatorState();
}

class _NewJudgmentCreatorState extends State<NewJudgmentCreator> {
  Patient? patient;

  void setPatient(Patient patient) {
    setState(() {
      this.patient = patient;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewJudgmentCreatorViewModel>(
      builder: (_, viewModel, __) {
        return Scaffold(
          body: viewModel.loaded
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PsychologistMenu(setPatient),
                      PatientInfo(patient),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: white, height: 2),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: viewModel.typeOfJudgments.length,
                          itemBuilder: (context, index) {
                            return SelectPsychologistJudgment(
                              name: viewModel.typeOfJudgments[index],
                              addRemoveJudgment: viewModel.addRemoveJudgment,
                              updateJudgment: viewModel.updateJudgment,
                              select: viewModel.judgments.where((element) => element.judgmentName == viewModel.typeOfJudgments[index]).isEmpty ? false : true,
                            );
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (patient == null || viewModel.judgments.isEmpty) {
                              var snackBar = const SnackBar(
                                content: Text('Wybierz pacjenta i jedno z orzeczeń'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            } else {
                              await viewModel.saveJudgments(patient!);
                            }
                          },
                          child: const Text('Zapisz'),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
