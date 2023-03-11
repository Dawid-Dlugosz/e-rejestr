import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/pdf/psychologist/utils/date_of_issue.dart';
import 'package:e_rejestr/pdf/psychologist/utils/delete_instruction.dart';
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
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget psychologist_uprzywilej({required Patient patient, required Judgment judgment}) {
  return pw.Column(
    children: [
      medicalLab(),
      header(judgment.number),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.Text(
          'W wyniku badania psychologicznego przeprowadzonego na podstawie art. 82 ust.1 pkt 6 ustawy z dnia 5 stycznia 2011 r. o kierujących pojazdami (Dz. U. z 2014 r. poz. 600)',
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
                text: 'brak / ',
                style: pw.TextStyle(
                  fontSize: 11,
                  decoration: judgment.state == 'brak' ? null : pw.TextDecoration.lineThrough,
                ),
              ),
              pw.TextSpan(
                text: ' istnienie',
                style: pw.TextStyle(
                  fontSize: 11,
                  decoration: judgment.state == 'brak' ? pw.TextDecoration.lineThrough : null,
                ),
              ),
              const pw.TextSpan(
                text: '**) przeciwwskazań psychologicznych do kierowania pojazdem uprzywilejowanym lub przewożącym wartości pieniężne:',
                style: pw.TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
      drivingVehiclesUprzywilej(a: true, b: true, c: true),
      pw.SizedBox(height: 30),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.RichText(
          text: pw.TextSpan(
            text: 'Termin ważności orzeczenia psychologicznego***) ',
            style: const pw.TextStyle(fontSize: 11),
            children: [pw.TextSpan(text: judgment.termOfValidyty, style: pw.TextStyle(fontWeight: pw.FontWeight.bold))],
          ),
        ),
      ),
      dataOfIssue(judgment.dateOfIssue, '****'),
      line(),
      instruction(),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Objaśnienia', style: const pw.TextStyle(fontSize: 8)),
          infoInstruction('*'),
          deleteInstruction('**'),
          judgmentDate('***'),
          psychologistInstruction('****'),
        ],
      ),
    ],
  );
}
