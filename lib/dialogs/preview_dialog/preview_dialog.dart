import 'package:e_rejestr/dialogs/preview_dialog/previed_item.dart';
import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/karta_kz.dart';
import 'package:e_rejestr/models/karta_kz_medical.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/view_models/new_judgment_creator_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviewDialog extends StatelessWidget {
  const PreviewDialog({required this.kartaKzMedical, required this.kartaKzPsycho, required this.path, required this.judgments, required this.medicalJudgments, required this.openFile, super.key});

  final String path;
  final List<Judgment> judgments;
  final List<MedicaJudgmentInterface> medicalJudgments;
  final Function(String path) openFile;
  final KartaKz? kartaKzPsycho;
  final KartaKzMedical? kartaKzMedical;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(25),
      child: Container(
        padding: const EdgeInsets.all(20),
        color: lightPurple,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Podgląd utworzonych plików'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Karty kz',
                        style: TextStyle(fontSize: 30, color: white),
                      ),
                      Row(
                        children: [
                          kartaKzMedical != null ? Text('jesty') : Container(),
                          kartaKzPsycho != null ? Text('jesty www') : Container(),
                        ],
                      ),
                    ],
                  ),
                  judgments.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Orzeczenia psychologiczne',
                              style: TextStyle(fontSize: 30, color: white),
                            ),
                            const SizedBox(height: 20),
                            Wrap(
                              spacing: 30,
                              runSpacing: 30,
                              children: [
                                ...judgments.map(
                                  (e) => PreviewItem(
                                    path: path,
                                    openFile: openFile,
                                    judgment: e,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      : Container(),
                  medicalJudgments.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Orzeczenia lekarskie',
                              style: TextStyle(fontSize: 30, color: white),
                            ),
                            const SizedBox(height: 20),
                            Wrap(
                              spacing: 30,
                              runSpacing: 30,
                              children: [
                                ...medicalJudgments.map(
                                  (e) => PreviewItem(
                                    path: path,
                                    openFile: openFile,
                                    mecicalJudgment: e,
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      : Container()
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Zapisz i drukuj'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
