import 'package:e_rejestr/pdf/psychologist/utlis/contraindications.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/date_of_issue.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/info_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/header.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/line.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/medical_lab.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/patient_name.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/pesel.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/psychologist_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/residence.dart';
import 'package:e_rejestr/pdf/psychologist/utlis/delete_instruction.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget Art_39k_ust_1_art_39m({required data}) {
  return pw.Column(
    children: [
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: medicalLab(),
      ),
      header('1/2/2023'),
      pw.Text(
        'W wyniku badania psychologicznego przeprowadzonego na podstawie art. 39k ust. 1/ art. 39m **) ustawy z dnia 6 września 2001 r. o transporcie drogowym (Dz. U. z 2021 r. poz. 919,1005,1997 z późn. zm.)',
        style: pw.TextStyle(fontSize: 11),
      ),
      patientName("Dawid Długosz"),
      pesel('iohjawdoiajdioawod;'),
      residence('Smocza 5 Siedlce'),
      contraindications(),
      pw.SizedBox(height: 30),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Termin następnego badania psychologicznego zgodnie z art. 39k ust. 3 pkt 1/ pkt 2 **) ustawy z dnia',
              style: pw.TextStyle(fontSize: 11, color: PdfColor.fromHex('#000000')),
            ),
            pw.RichText(
              text: pw.TextSpan(text: '6 września 2001r. o transporcie drogowym ', style: pw.TextStyle(color: PdfColor.fromHex('#000000'), fontSize: 11), children: [pw.TextSpan(text: data, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11, color: PdfColor.fromHex('#000000')))]),
            )
          ],
        ),
      ),
      dataOfIssue('22-05-2022'),
      line(),
      instruction(),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Objaśnienia', style: pw.TextStyle(fontSize: 8)),
          infoInstruction('*)'),
          deleteInstruction('**)'),
          psychologistInstruction('***)'),
        ],
      ),
    ],
  );
}
