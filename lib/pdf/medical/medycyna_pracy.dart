import 'package:e_rejestr/models/medicine.dart';
import 'package:e_rejestr/pdf/medical/utils/date_of_validity_kodeks.dart';
import 'package:e_rejestr/pdf/medical/utils/medical_header.dart';
import 'package:e_rejestr/pdf/medical/utils/medical_title.dart';
import 'package:e_rejestr/pdf/medical/utils/patient_name_kodeks.dart';
import 'package:e_rejestr/pdf/medical/utils/patient_pesel_kodeks.dart';
import 'package:e_rejestr/pdf/medical/utils/patient_residence_kodeks.dart';
import 'package:e_rejestr/pdf/medical/utils/work.dart';
import 'package:e_rejestr/pdf/medical/utils/work_position.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget medycyna_pracy({required Medicine judgment}) {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Column(
      children: [
        medicalHeader(
          judgment.dateOfIssue,
          showCity: false,
          type: true,
        ),
        medical_title(number: judgment.number),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Text(
            'wydane na podstawie skierowania na badania lekarskie z dnia : ',
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.Text(
          'W wyniku badania lekarskiego i oceny narażeń występujących na stanowisku pracy, stosownie do art. 43 pkt 2 i art. 229 § 4 ustawy z dnia 26 czerwca 1974 r. – Kodeks pracy ((t.j.Dz. U. z 2019 r. poz. 1040 z późn. Zm.), orzeka się, że:',
          style: const pw.TextStyle(fontSize: 10),
        ),
        patientNameKodeks(judgment.patient.getFullName()),
        patientPeselKodeks(judgment.patient.getDocument()),
        patientResidenceKodeks(judgment.patient.residentialAddress.toString()),
        work(judgment.firm.toString()),
        pw.SizedBox(height: 10),
        workPosition(judgment.workPosition, a: judgment.checkboxA, b: judgment.checkboxB, c: judgment.checkboxC, date: judgment.checkboxCDate),
        pw.SizedBox(height: 20),
        date_of_validyty_kodeks(judgment.dateOfValidity, judgment.judgmentName),
        pw.SizedBox(height: 280),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'Łuków ${judgment.dateOfIssue}',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  '(miejscowość, data)',
                  style: const pw.TextStyle(fontSize: 8),
                ),
              ],
            ),
            pw.Column(
              children: [
                pw.Text(
                  '............................................................................',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  '  (pieczątka i podpis lekarza przeprowadzającego badanie lekarskie)',
                  style: const pw.TextStyle(fontSize: 8),
                ),
              ],
            ),
          ],
        )
      ],
    ),
  );
}
