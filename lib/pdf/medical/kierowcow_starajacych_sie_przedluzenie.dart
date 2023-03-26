import 'package:e_rejestr/models/medical_judgment.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/pdf/medical/utils/cars.dart';
import 'package:e_rejestr/pdf/medical/utils/evidence.dart';
import 'package:e_rejestr/pdf/medical/utils/limitations.dart';
import 'package:e_rejestr/pdf/medical/utils/medical_header.dart';
import 'package:e_rejestr/pdf/medical/utils/medical_title.dart';
import 'package:e_rejestr/pdf/medical/utils/patient_name.dart';
import 'package:e_rejestr/pdf/medical/utils/patient_pesel.dart';
import 'package:e_rejestr/pdf/medical/utils/therm_of_validate.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget kierowca_starajacy_sie_przedluzenie({required MedicalJudgment judgment, required Patient patient}) {
  return pw.Column(
    children: [
      medicalHeader(judgment.dateOfIssue),
      medical_title(number: judgment.number),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.RichText(
          text: const pw.TextSpan(
            text: 'W wyniku badania lekarskiego przeprowadzonego na podstawie',
            style: pw.TextStyle(fontSize: 10),
            children: [
              pw.TextSpan(
                text: ' art. 75 ust. 1  ',
                style: pw.TextStyle(
                  fontSize: 10,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
              pw.TextSpan(
                text: ' pkt 1 / ',
                style: pw.TextStyle(
                  fontSize: 10,
                  decoration: pw.TextDecoration.lineThrough,
                ),
              ),
              pw.TextSpan(
                text: '  pkt 2/  ',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
              pw.TextSpan(
                text: ' pkt 3/ pkt 4/ pkt 5/pkt 7/pkt 8 ',
                style: pw.TextStyle(
                  fontSize: 10,
                  decoration: pw.TextDecoration.lineThrough,
                ),
              ),
              pw.TextSpan(
                text: ' 1 )  ',
                baseline: 6,
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
              pw.TextSpan(
                text: '  ustawy z dnia 5 stycznia 2011 r. o kierujących pojazdami (Dz. U. z 2021r. poz. 1212, z późn. zm.) ',
                style: pw.TextStyle(
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
      patientName(patient.getFullName()),
      patientPesel(patient.getDocument()),
      pw.Align(
        alignment: pw.Alignment.center,
        child: pw.Padding(
          padding: const pw.EdgeInsets.only(top: 20, bottom: 10),
          child: pw.Text(
            'Stwierdzam',
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
        ),
      ),
      pw.Align(
        alignment: pw.Alignment.centerLeft,
        child: pw.RichText(
          text: pw.TextSpan(
            text: '1) ',
            style: const pw.TextStyle(fontSize: 11),
            children: [
              pw.TextSpan(
                text: ' Brak ',
                style: pw.TextStyle(
                  fontSize: 10,
                  decoration: judgment.state == 'brak' ? null : pw.TextDecoration.lineThrough,
                ),
              ),
              const pw.TextSpan(
                text: ' / ',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
              pw.TextSpan(
                text: 'istnienie',
                style: pw.TextStyle(
                  fontSize: 10,
                  decoration: judgment.state == 'brak' ? pw.TextDecoration.lineThrough : null,
                ),
              ),
              const pw.TextSpan(
                text: ' 1) ',
                baseline: 6,
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
              const pw.TextSpan(
                text: ' przeciwwskazań zdrowotnych do kierowania pojazdami, do których jest wymagane:',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ),
      cars(a: judgment.carA, b: judgment.carB, c: judgment.carC, d: judgment.carD),
      limitions(judgment.limitA, judgment.limitB),
      thermOfValidate(judgment.dateOfValidity),
      evidence()
    ],
  );
}
