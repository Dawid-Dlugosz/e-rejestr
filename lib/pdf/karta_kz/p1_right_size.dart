import 'package:e_rejestr/pdf/karta_kz/cail_header.dart';
import 'package:e_rejestr/pdf/karta_kz/cail_row.dart';
import 'package:e_rejestr/pdf/karta_kz/text_field.dart';
import 'package:e_rejestr/pdf/psychologist/utils/date_of_issue.dart';
import 'package:e_rejestr/pdf/psychologist/utils/delete_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/info_instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/instruction.dart';
import 'package:e_rejestr/pdf/psychologist/utils/line.dart';
import 'package:e_rejestr/pdf/psychologist/utils/medical_lab.dart';
import 'package:e_rejestr/pdf/psychologist/utils/psychologist_instruction.dart';
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
          height: 30,
        ),
        medicalLab(),
        pw.SizedBox(
          height: 10,
        ),
        pw.Container(
          width: width,
          child: pw.Text(
            'KARTA BADANIA PSYCHOLOGICZNEGO',
            style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.Column(
          children: [
            cailHeader('osoba badana', width: width),
            cailRow('Imię i nazwisko', width: width),
            pw.Row(
              children: [
                cailRow('Numer PESEL (w przypadku osoby nieposiadającej Numeru PESEL podać nazwę i numer dokumentu stwierzającego tożsamosć)', width: 300, height: 40),
                cailRow('Wiek', width: 50, height: 40),
                cailRow('Płeć*', text: 'K/M', width: 50, height: 40),
              ],
            ),
            pw.Row(
              children: [
                cailRow('Adres', width: width / 2),
                cailRow('Wykształcenie', width: width / 2),
              ],
            ),
            pw.Row(
              children: [
                cailRow('Data badania', width: width / 2),
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
