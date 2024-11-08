import 'package:e_rejestr/dialogs/firm_container.dart';
import 'package:e_rejestr/dialogs/preview_dialog/preview_dialog.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/models/firm.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/view_models/firm_view_model.dart';
import 'package:e_rejestr/view_models/new_judgment_creator_view_model.dart';
import 'package:e_rejestr/widgets/firm_info.dart';
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
      model.patient = patient;
    });
  }

  void setFirm(Firm firm) {
    setState(() {
      this.firm = firm;
      model.firm = firm;
    });
  }

  void clearFirm() {
    setState(() {
      firm = null;
      model.firm = null;
      model.judgmentMedicals.removeWhere((element) => element.judgmentName == medicalMedycynaPracy || element.judgmentName == medicalMedycynaPracyInstruktor);
    });
  }

  Future<void> saveJudgment({bool saveAndPrint = false}) async {
    {
      if (model.patient == null) {
        var snackBar = const SnackBar(
          content: Text('Wybierz pacjenta'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        await model.saveFiles();
        if (!saveAndPrint) {
          setState(() {
            model.showPreviewPopup = true;
          });
        } else {
          printAndSave();
        }
      }
    }
  }

  void printAndSave() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: model.printFiles(),
          );
        }).then(
      (value) async => await model.addToFirebase(),
    );
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
                  kartaKzPsycho: viewModel.kartaKzPsycho,
                  kartaKzMedical: viewModel.kartaKzMedical,
                  edit: viewModel.documentType != null,
                );
              },
            ).then(
              (value) {
                setState(() {
                  viewModel.showPreviewPopup = false;
                });
                if (value != null && value == true) {
                  printAndSave();
                } else if (value != null && value == 'edit') {
                  viewModel.editJudgment();
                } else {
                  viewModel.removeFiles();
                }
              },
            );
          }
        });
        model = viewModel;
        return Scaffold(
          appBar: viewModel.documentType != null
              ? AppBar(
                  title: const Text('Edytuj orzeczenie'),
                )
              : null,
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
                            PatientInfo(viewModel.patient, hideRegisters: viewModel.documentType != null),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                viewModel.firm != null
                                    ? FirmInfo(viewModel.firm!, clearFirm)
                                    : ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ChangeNotifierProvider(
                                                create: (_) => FirmViewModel(),
                                                child: const FirmContainer(),
                                              );
                                            },
                                          ).then(
                                            (value) {
                                              if (value != null) {
                                                setFirm(value);
                                              }
                                            },
                                          );
                                        },
                                        child: const Text('Wybierz firmę'),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      viewModel.documentType == null
                          ? Wrap(
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: CheckboxListTile(
                                    title: const Text('Nadaj własny numer'),
                                    value: viewModel.enableTextFieldPsycho,
                                    onChanged: (value) {
                                      setState(() {
                                        viewModel.enableTextFieldPsycho = value!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 300,
                                  child: TextField(
                                    enabled: viewModel.enableTextFieldPsycho,
                                    controller: viewModel.psychoTextCotroller,
                                    decoration: const InputDecoration(
                                      hintText: '1/3/23',
                                      label: Text('numer badania psychologicznego'),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      const SizedBox(height: 5),
                      viewModel.documentType == null
                          ? Wrap(
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: CheckboxListTile(
                                    title: const Text('Nadaj własny numer'),
                                    value: viewModel.enableTextFieldMedic,
                                    onChanged: (value) {
                                      setState(() {
                                        viewModel.enableTextFieldMedic = value!;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 300,
                                  child: TextField(
                                    enabled: viewModel.enableTextFieldMedic,
                                    controller: viewModel.medicalTextController,
                                    decoration: const InputDecoration(
                                      hintText: '1/3/23',
                                      label: Text('numer badania medycznego'),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      viewModel.enableTextFieldMedic == true || viewModel.enableTextFieldPsycho == true
                          ? const Text(
                              'Jeśli jest włączone wpysywanie własnego numeru, numer automatycznie nie zaktualizuje się w bazie!',
                              style: TextStyle(color: white),
                            )
                          : Container(),
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: white, height: 2),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            viewModel.documentType != null && viewModel.documentType == DocumentType.medical
                                ? Container()
                                : Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ...viewModel.typeOfJudgments.map(
                                            (e) => SelectPsychologistJudgment(
                                              name: e,
                                              addRemoveJudgment: viewModel.addRemoveJudgment,
                                              updateJudgment: viewModel.updateJudgment,
                                              dateOfIssue: viewModel.documentType != null ? viewModel.kartaKzPsycho!.judgments[0].dateOfIssue : null,
                                              select: viewModel.judgments.where((element) => element.judgmentName == e).isEmpty ? false : true,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            const SizedBox(width: 20),
                            viewModel.documentType != null && viewModel.documentType == DocumentType.psycho
                                ? Container()
                                : Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ...viewModel.typeOfJudgmentsMedical.map((e) {
                                            if (e == medicalMedycynaPracyInstruktor || e == medicalMedycynaPracy) {
                                              return viewModel.firm != null
                                                  ? SelectMedicineJudgment(
                                                      name: e,
                                                      addRemoveJudgment: viewModel.addRemoveMedicalJudgment,
                                                      updateJudgment: viewModel.updateMedicalJudgment,
                                                      select: viewModel.judgmentMedicals.where((element) => element.judgmentName == e).isEmpty ? false : true,
                                                      dateOfIssue: viewModel.documentType != null ? viewModel.kartaKzMedical!.judgments[0].dateOfIssue : null,
                                                      firm: viewModel.firm,
                                                      setFirm: setFirm,
                                                    )
                                                  : Container();
                                            } else {
                                              return SelectMedicalJudgment(
                                                name: e,
                                                addRemoveJudgment: viewModel.addRemoveMedicalJudgment,
                                                updateJudgment: viewModel.updateMedicalJudgment,
                                                dateOfIssue: viewModel.documentType != null ? viewModel.kartaKzMedical!.judgments[0].dateOfIssue : null,
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
                      viewModel.documentType == null
                          ? Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                onPressed: viewModel.judgments.isEmpty && viewModel.judgmentMedicals.isEmpty ? null : () async => saveJudgment(saveAndPrint: true),
                                child: const Text('Zapisz i drukuj'),
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                onPressed: viewModel.judgments.isEmpty && viewModel.judgmentMedicals.isEmpty ? null : () async => viewModel.editJudgment(),
                                child: const Text('Edytuj i drukuj'),
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
