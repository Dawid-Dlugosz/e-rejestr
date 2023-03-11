import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/pdf/psychologist/utils/date_of_issue.dart';
import 'package:e_rejestr/pdf/psychologist/utils/delete_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/header.dart';
import 'package:e_rejestr/pdf/psychologist/utils/info_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/line.dart';
import 'package:e_rejestr/pdf/psychologist/utils/medical_lab.dart';
import 'package:e_rejestr/pdf/psychologist/utils/patient_name.dart';
import 'package:e_rejestr/pdf/psychologist/utils/pesel.dart';

import 'package:e_rejestr/pdf/psychologist/utils/psychologist_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/residence.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../models/patient.dart';

pw.Widget psychologist_egzaminator_instruktor({required Patient patient, required Judgment judgment}) {
  return pw.Column(
    children: [
      medicalLab(),
      header(judgment.number),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Text(
          'W wyniku badania psychologicznego przeprowadzonego na podstawie art. 82 ust.2 pkt 1/ pkt 2 ustawy z dnia 5 stycznia 2011 r. o kierujących pojazdami (Dz. U. z 2014 r. poz. 600)',
          style: pw.TextStyle(fontSize: 11, color: PdfColor.fromHex('#000000')),
        ),
      ),
      patientName(patient.getFullName()),
      pesel(patient.getDocument()),
      residence(patient.residentialAddress.toString()),
      pw.SizedBox(height: 15),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.RichText(
          text: pw.TextSpan(
            text: 'stwierdzam ',
            style: const pw.TextStyle(fontSize: 11),
            children: [
              pw.TextSpan(
                text: 'brak/ ',
                style: pw.TextStyle(
                  fontSize: 11,
                  decoration: judgment.state == 'brak' ? null : pw.TextDecoration.lineThrough,
                ),
              ),
              pw.TextSpan(
                text: 'istnienie ',
                style: pw.TextStyle(
                  fontSize: 11,
                  decoration: judgment.state == 'brak' ? pw.TextDecoration.lineThrough : null,
                ),
              ),
              const pw.TextSpan(
                text: '**) przeciwwskazań psychologicznych do wykonywania czynności ',
                style: pw.TextStyle(fontSize: 11),
              ),
              pw.TextSpan(
                text: 'instruktora/',
                style: pw.TextStyle(
                  fontSize: 11,
                  decoration: judgment.carA ? null : pw.TextDecoration.lineThrough,
                ),
              ),
              pw.TextSpan(
                text: ' egzaminatora/ ',
                style: pw.TextStyle(
                  fontSize: 11,
                  decoration: judgment.carB ? null : pw.TextDecoration.lineThrough,
                ),
              ),
              pw.TextSpan(
                text: ' instruktora technik jazdy:',
                style: pw.TextStyle(
                  fontSize: 11,
                  decoration: judgment.carC ? null : pw.TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ),
      ),
      pw.SizedBox(height: 20),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Text(
          'Termin ważności orzeczenia psychologicznego zgodnie  z art. 34 ust. 5 pkt 1/ pkt 2**) ustawy z dnia',
          style: const pw.TextStyle(fontSize: 11),
        ),
      ),
      pw.Row(
        children: [
          pw.Text(
            '5 stycznia 2011 r. o kierujących pojazdami:',
            style: const pw.TextStyle(fontSize: 11),
          ),
          pw.Text(
            judgment.termOfValidyty,
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
      dataOfIssue(judgment.dateOfIssue, '***'),
      line(),
      instruction(),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Objaśnienia', style: const pw.TextStyle(fontSize: 8)),
          infoInstruction('*'),
          deleteInstruction('**'),
          psychologistInstruction('***'),
        ],
      ),
    ],
  );
}
