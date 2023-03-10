import 'dart:math';

import 'package:e_rejestr/dialogs/firm_container.dart';
import 'package:e_rejestr/dialogs/preview_dialog/preview_dialog.dart';
import 'package:e_rejestr/models/firm.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/pdf/karta_kz/p1_right_size.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/utils/pages.dart';
import 'package:e_rejestr/view_models/firm_view_model.dart';
import 'package:e_rejestr/view_models/new_judgment_creator_view_model.dart';
import 'package:e_rejestr/widgets/firm_info.dart';
import 'package:e_rejestr/widgets/my_app_bar.dart';
import 'package:e_rejestr/widgets/patient_info.dart';
import 'package:e_rejestr/widgets/psychologist_menu.dart';
import 'package:e_rejestr/widgets/select_medical/select_medical_judgment.dart';
import 'package:e_rejestr/widgets/select_medicine/select_medicine_judgment.dart';
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
  Firm? firm;
  late NewJudgmentCreatorViewModel model;

  void setPatient(Patient patient) {
    setState(() {
      this.patient = patient;
    });
  }

  void setFirm(Firm firm) {
    setState(() {
      this.firm = firm;
    });
  }

  void clearFirm() {
    setState(() {
      firm = null;
      model.judgmentMedicals.removeWhere((element) => element.judgmentName == medicalMedycynaPracy || element.judgmentName == medicalMedycynaPracyInstruktor);
    });
  }

  Future<void> saveJudgment({bool saveAndPrint = false}) async {
    {
      if (patient == null) {
        var snackBar = const SnackBar(
          content: Text('Wybierz pacjenta'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        await model.saveJudgments(patient!, saveAndPrint: saveAndPrint);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewJudgmentCreatorViewModel>(
      builder: (_, viewModel, __) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (viewModel.showPreviewPopup) {
            showDialog(
              context: context,
              builder: (context) {
                return PreviewDialog(
                  path: viewModel.filePath,
                  judgments: viewModel.judgments,
                  medicalJudgments: viewModel.judgmentMedicals,
                  openFile: viewModel.openFile,
                );
              },
            ).then(
              (value) {
                setState(() {
                  viewModel.showPreviewPopup = false;
                });
                if (value != null && value == true) {
                  // TODO ZAPISZ PLIKÓW I TWORZENIE KART
                } else {
                  viewModel.removeFiles();
                }
              },
            );
          }
        });
        model = viewModel;
        return Scaffold(
          body: viewModel.loaded
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PsychologistMenu(setPatient),
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          runSpacing: 30,
                          spacing: 30,
                          runAlignment: WrapAlignment.spaceBetween,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            PatientInfo(patient),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                firm == null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ChangeNotifierProvider(
                                                create: (_) => FirmViewModel(),
                                                child: const FirmContainer(),
                                              );
                                            },
                                          ).then((value) {
                                            if (value != null) {
                                              setFirm(value);
                                            }
                                          });
                                        },
                                        child: const Text('Wybierz firmę'),
                                      )
                                    : const SizedBox(
                                        width: 1,
                                        height: 1,
                                      ),
                                firm != null ? FirmInfo(firm!, clearFirm) : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: white, height: 2),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...viewModel.typeOfJudgments.map(
                                      (e) => SelectPsychologistJudgment(
                                        name: e,
                                        addRemoveJudgment: viewModel.addRemoveJudgment,
                                        updateJudgment: viewModel.updateJudgment,
                                        select: viewModel.judgments.where((element) => element.judgmentName == e).isEmpty ? false : true,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...viewModel.typeOfJudgmentsMedical.map((e) {
                                      if (e == medicalMedycynaPracyInstruktor || e == medicalMedycynaPracy) {
                                        return firm != null
                                            ? SelectMedicineJudgment(
                                                name: e,
                                                addRemoveJudgment: viewModel.addRemoveMedicalJudgment,
                                                updateJudgment: viewModel.updateMedicalJudgment,
                                                select: viewModel.judgmentMedicals.where((element) => element.judgmentName == e).isEmpty ? false : true,
                                                firm: firm,
                                                setFirm: setFirm,
                                              )
                                            : Container();
                                      } else {
                                        return SelectMedicalJudgment(
                                          name: e,
                                          addRemoveJudgment: viewModel.addRemoveMedicalJudgment,
                                          updateJudgment: viewModel.updateMedicalJudgment,
                                          select: viewModel.judgmentMedicals.where((element) => element.judgmentName == e).isEmpty ? false : true,
                                        );
                                      }
                                    })
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: viewModel.judgments.isEmpty && viewModel.judgmentMedicals.isEmpty ? null : () async => saveJudgment(),
                          child: const Text('Podgląd'),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: viewModel.judgments.isEmpty && viewModel.judgmentMedicals.isEmpty ? null : () async => saveJudgment(saveAndPrint: true),
                          child: const Text('Zapisz i drukuj'),
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
