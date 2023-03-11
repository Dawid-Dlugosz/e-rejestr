import 'package:diacritic/diacritic.dart';
import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PreviewItem extends StatelessWidget {
  const PreviewItem({required this.openFile, required this.path, this.judgment, this.mecicalJudgment, super.key});

  final Function(String path) openFile;
  final String path;
  final Judgment? judgment;
  final MedicaJudgmentInterface? mecicalJudgment;

  String getName() {
    if (judgment != null) {
      return removeDiacritics(judgment!.judgmentName.replaceAll(' ', '-'));
    }
    return removeDiacritics(mecicalJudgment!.judgmentName.replaceAll(' ', '-'));
  }

  String getNumber() {
    if (judgment != null) {
      return judgment!.number.replaceAll('/', '-');
    }
    return mecicalJudgment!.number.replaceAll('/', '-');
  }

  @override
  Widget build(BuildContext context) {
    var filePath = path + '\\' + getName() + '-' + getNumber() + '.pdf';
    filePath = filePath.replaceAll('/', '\\');

    return InkWell(
      onTap: () => openFile(filePath),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(color: white), borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            const Icon(
              Icons.picture_as_pdf,
              color: white,
              size: 50,
            ),
            Text(
              judgment != null
                  ? judgment!.judgmentName
                  : mecicalJudgment != null
                      ? mecicalJudgment!.judgmentName
                      : '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
