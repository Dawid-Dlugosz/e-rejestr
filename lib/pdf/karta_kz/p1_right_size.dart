import 'package:e_rejestr/pdf/karta_kz/cail_row.dart';
import 'package:e_rejestr/pdf/karta_kz/text_field.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/date_of_issue.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/delete_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/info_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/line.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/medical_lab.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/psychologist_instruction.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

const padding = 5.0;
const width = 400.0;
const rowHeight = 30;

pw.Widget p1_right_side(String nrRej) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(left: 10.0),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(),
          ),
          padding: const pw.EdgeInsets.all(10),
          child: pw.Text(
            'Nr rej. ${nrRej}',
            style: pw.TextStyle(fontSize: 11),
          ),
        ),
        pw.SizedBox(
          height: 40,
        ),
        medicalLab(),
        pw.Text(
          'KARTA BADANIA PSYCHOLOGICZNEGO',
          style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
        ),
        pw.Column(
          children: [
            pw.Container(
              width: width,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              padding: pw.EdgeInsets.all(padding),
              child: pw.Text('OSOBA BADANA', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            cailRow('Imię i nazwisko'),
          ],
        ),
      ],
    ),
  );
}
