import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/models/karta_kz.dart';
import 'package:e_rejestr/models/karta_kz_medical.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/files.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class KzPreview extends StatelessWidget {
  KzPreview({required this.path, required this.openFile, this.kartaKzMedical, this.kartaKz, super.key});

  final Function(String filePath) openFile;
  final String path;
  KartaKz? kartaKz;
  KartaKzMedical? kartaKzMedical;

  String getName() {
    if (kartaKz != null) {
      return 'Psychologiczna karta kz';
    } else if (kartaKzMedical != null) {
      return 'Medyczna karta kz';
    } else {
      return '';
    }
  }

  String getPath() {
    if (kartaKz != null) {
      return getKzFileWithPath(path: path, number: kartaKz!.number, type: DocumentType.psycho).path;
    } else if (kartaKzMedical != null) {
      return getKzFileWithPath(path: path, number: kartaKzMedical!.number, type: DocumentType.medical).path;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openFile(getPath()),
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
              getName(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
    ;
  }
}
