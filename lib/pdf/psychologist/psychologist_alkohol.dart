import 'package:e_rejestr/pdf/psychologist/utils/contraindications.dart';
import 'package:e_rejestr/pdf/psychologist/utils/date_of_issue.dart';
import 'package:e_rejestr/pdf/psychologist/utils/delete_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/driving_vehicles.dart';
import 'package:e_rejestr/pdf/psychologist/utils/header.dart';
import 'package:e_rejestr/pdf/psychologist/utils/info_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/judgment_date.dart';
import 'package:e_rejestr/pdf/psychologist/utils/line.dart';
import 'package:e_rejestr/pdf/psychologist/utils/medical_lab.dart';
import 'package:e_rejestr/pdf/psychologist/utils/patient_name.dart';
import 'package:e_rejestr/pdf/psychologist/utils/pesel.dart';
import 'package:e_rejestr/pdf/psychologist/utils/psychologist_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/residence.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget psychologist_alkohol({required String date}) {
  return pw.Column(
    children: [
      medicalLab(),
      header('1/2/2023'),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Text(
          'W wyniku badania psychologicznego przeprowadzonego na podstawie ',
          style: pw.TextStyle(fontSize: 11, color: PdfColor.fromHex('#000000')),
        ),
      ),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.RichText(
          text: const pw.TextSpan(
            text: 'a)    art. 82 ust.1 pkt 1',
            style: pw.TextStyle(fontSize: 11),
            children: [
              pw.TextSpan(
                text: 'pkt 1 lit. a / lit. b / lit. c / pkt 2 / pkt 3 / ',
                style: pw.TextStyle(
                  fontSize: 11,
                  decoration: pw.TextDecoration.lineThrough,
                ),
              ),
              pw.TextSpan(
                text: ' pkt 4 lit. a ',
                style: pw.TextStyle(
                  fontSize: 11,
                ),
              ),
              pw.TextSpan(
                text: ' / lit. b / lit. c / pkt 5 **) ',
                style: pw.TextStyle(
                  fontSize: 11,
                  decoration: pw.TextDecoration.lineThrough,
                ),
              )
            ],
          ),
        ),
      ),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Text(
          'b)    art. 82 ust. 2 pkt 3/4',
          style: pw.TextStyle(
            fontSize: 11,
            decoration: pw.TextDecoration.lineThrough,
          ),
        ),
      ),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Text(
          'ustawy z dnia 5 stycznia 2011 r. o kierujących pojazdami (Dz. U. z 2019r. poz. 341, 622, i 1287).',
          style: pw.TextStyle(fontSize: 11),
        ),
      ),
      patientName("Dawid Długosz"),
      pesel('iohjawdoiajdioawod;'),
      residence('Smocza 5 Siedlce'),
      pw.SizedBox(height: 15),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.RichText(
          text: const pw.TextSpan(
            text: 'stwierdzam brak/',
            style: pw.TextStyle(fontSize: 11),
            children: [
              pw.TextSpan(
                text: 'istnienie ',
                style: pw.TextStyle(fontSize: 11, decoration: pw.TextDecoration.lineThrough),
              ),
              pw.TextSpan(
                text: '**) przeciwwskazań psychologicznych do kierowania:',
                style: pw.TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
      drivingVehicles(a: true),
      pw.SizedBox(height: 30),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.RichText(
          text: pw.TextSpan(
            text: 'Termin ważności orzeczenia psychologicznego***) ',
            style: pw.TextStyle(fontSize: 11),
            children: [pw.TextSpan(text: date, style: pw.TextStyle(fontWeight: pw.FontWeight.bold))],
          ),
        ),
      ),
      dataOfIssue('22-05-2022', '****'),
      line(),
      instruction(),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Objaśnienia', style: pw.TextStyle(fontSize: 8)),
          infoInstruction('*'),
          deleteInstruction('**'),
          judgmentDate('***'),
          psychologistInstruction('****'),
        ],
      ),
    ],
  );
}
