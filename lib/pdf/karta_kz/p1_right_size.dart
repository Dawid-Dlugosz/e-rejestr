import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/pdf/karta_kz/cail_header.dart';
import 'package:e_rejestr/pdf/karta_kz/cail_row.dart';
import 'package:e_rejestr/pdf/psychologist/utils/medical_lab.dart';
import 'package:pdf/widgets.dart' as pw;

const padding = 5.0;
const width = 400.0;
const rowHeight = 30;

pw.Widget p1_right_side({required String nrRej, required Patient patient, required String dateOfIssue}) {
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
            'Nr rej. $nrRej',
            style: const pw.TextStyle(fontSize: 11),
          ),
        ),
        pw.SizedBox(
          height: 30,
        ),
        medicalLab(),
        pw.SizedBox(
          height: 10,
        ),
        pw.Container(
          width: width,
          child: pw.Text(
            'KARTA BADANIA',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.Column(
          children: [
            cailHeader('osoba badana', width: width),
            cailRow('Imię i nazwisko', width: width, text: patient.getFullName()),
            pw.Row(
              children: [
                cailRow('Numer PESEL (w przypadku osoby nieposiadającej Numeru PESEL podać nazwę i numer dokumentu stwierzającego tożsamosć)', width: 300, height: 40, text: patient.getDocument()),
                cailRow('Wiek', width: 50, height: 40),
                cailRow('Płeć*', text: 'K/M', width: 50, height: 40),
              ],
            ),
            pw.Row(
              children: [
                cailRow('Adres', width: width / 2, text: patient.residentialAddress.toString()),
                cailRow('Wykształcenie', width: width / 2),
              ],
            ),
            pw.Row(
              children: [
                cailRow('Data badania', width: width / 2, text: dateOfIssue),
                cailRow('Data poprzedniego badania', width: width / 2),
              ],
            ),
            pw.Row(
              children: [
                cailRow('Posiadane kategorie prawa jazdy', width: width / 2),
                cailRow('Podmiot wydający prawo jazdy', width: width / 2),
              ],
            ),
            cailRow('Cel Badania', width: width),
            cailRow('Podmiot kierujący na badanie, jeśli dotyczy', width: width),
            cailHeader('Wyniki badania psychologicznego', width: width),
            cailRow('Treść orzeczenia', width: width, height: 50),
            cailRow('Uzasadnienie treści orzeczenia', width: width, height: 70),
            cailRow('Podpis uprawnionego psychologa ***)', width: width),
            cailRow('Potwierdzenie odbioru orzeczenia psychologicznego (data i podpis osoby badanej)', width: width),
            cailRow('Orzeczenie / kopię orzeczenia wysłano, jeśłi dotyczy)', text: 'Dnia....................................................................... do................................................................................................................................................', width: width),
          ],
        ),
      ],
    ),
  );
}
