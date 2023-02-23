import 'package:e_rejestr/pdf/karta_kz/disease.dart';
import 'package:e_rejestr/pdf/karta_kz/disense_list.dart';
import 'package:e_rejestr/pdf/karta_kz/medical_step.dart';
import 'package:e_rejestr/pdf/karta_kz/p2_header.dart';
import 'package:e_rejestr/pdf/karta_kz/tests_and_results.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget p2_left_side() {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Container(
        width: 400,
        child: pw.Align(
          alignment: pw.Alignment.center,
          child: pw.Text(
            'PRZEBIEG BADANIA',
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
          ),
        ),
      ),
      p2Header(1, 'DANE Z WYWIADU BEZPOREDNIEGO I OBSERWACJI OSOBY BADANEJ'),
      pw.Container(
        width: 400,
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        padding: const pw.EdgeInsets.all(5),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            medicalSep('Prowadzenie pojazdu:'),
            pw.SizedBox(height: 20),
            medicalSep('Funkcjonowanie zawodowe:'),
            pw.SizedBox(height: 40),
            medicalSep('Przyjmowane leki:'),
            pw.SizedBox(height: 10),
            medicalSep('Przebyte urazy i operacje:'),
            pw.SizedBox(height: 20),
            medicalSep('Przebyte i aktualne choroby:'),
            pw.SizedBox(height: 10),
            diseaseList(),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 5),
              child: pw.Text(
                'Dodatkowe spostrzeżenia i informacje:',
                maxLines: 2,
                style: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      pw.SizedBox(height: 20),
      p2Header(2, 'OCENA I OPIS OOSOBY BADANEJ POD WZGLĘDEM SPRAWNOSĆI INTELEKTUALNEJ I PROCESÓW '),
      testsAndResults(),
    ],
  );
}
