import 'package:e_rejestr/pdf/psychologist/utils/contraindications.dart';
import 'package:e_rejestr/pdf/psychologist/utils/date_of_issue.dart';
import 'package:e_rejestr/pdf/psychologist/utils/delete_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/driving_vehicles.dart';
import 'package:e_rejestr/pdf/psychologist/utils/driving_vehicles_uprzywilej.dart';
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

pw.Widget psychologist_egzaminator_instruktor({required String date}) {
  return pw.Column(
    children: [
      medicalLab(),
      header('1/2/2023'),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Text(
          'W wyniku badania psychologicznego przeprowadzonego na podstawie art. 82 ust.2 pkt 1/ pkt 2 ustawy z dnia 5 stycznia 2011 r. o kierujących pojazdami (Dz. U. z 2014 r. poz. 600)',
          style: pw.TextStyle(fontSize: 11, color: PdfColor.fromHex('#000000')),
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
            text: 'stwierdzam ',
            style: pw.TextStyle(fontSize: 11),
            children: [
              pw.TextSpan(
                text: 'brak/ ',
                style: pw.TextStyle(fontSize: 11, decoration: null),
              ),
              pw.TextSpan(
                text: 'istnienie ',
                style: pw.TextStyle(fontSize: 11, decoration: pw.TextDecoration.lineThrough),
              ),
              pw.TextSpan(
                text: '**) przeciwwskazań psychologicznych do wykonywania czynności',
                style: pw.TextStyle(fontSize: 11),
              ),
              pw.TextSpan(
                text: 'instruktora/',
                style: pw.TextStyle(fontSize: 11),
              ),
              pw.TextSpan(
                text: ' egzaminatora/ instruktora technik jazdy:',
                style: pw.TextStyle(fontSize: 11),
              ),
              pw.TextSpan(
                text: ' instruktora technik jazdy:',
                style: pw.TextStyle(fontSize: 11),
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
          style: pw.TextStyle(fontSize: 11),
        ),
      ),
      pw.Row(
        children: [
          pw.Text(
            '5 stycznia 2011 r. o kierujących pojazdami:',
            style: pw.TextStyle(fontSize: 11),
          ),
          pw.Text(
            'AWAWDAWWAWA',
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
      dataOfIssue('22-05-2022', '***'),
      line(),
      instruction(),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Objaśnienia', style: pw.TextStyle(fontSize: 8)),
          infoInstruction('*'),
          deleteInstruction('**'),
          psychologistInstruction('***'),
        ],
      ),
    ],
  );
}
