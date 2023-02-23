import 'package:e_rejestr/pdf/karta_kz/text_field.dart';
import 'package:e_rejestr/pdf/psychologist/utils/date_of_issue.dart';
import 'package:e_rejestr/pdf/psychologist/utils/delete_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/info_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/line.dart';
import 'package:e_rejestr/pdf/psychologist/utils/psychologist_instruction.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget p1_left_side() {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(right: 10.0),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        textField('5 WNIOSKI'),
        textField('6 ZALECENIA'),
        dataOfIssue('22-05-2022', '***', padding: false, width: 400),
        pw.SizedBox(height: 15),
        line(width: 400, margin: false),
        infoInstruction('*', size: true),
        deleteInstruction('**'),
        psychologistInstruction('***'),
      ],
    ),
  );
}
