import 'package:e_rejestr/pdf/karta_kz/p2_header.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget p2_left_side() {
  return pw.Column(
    children: [
      pw.Text('PRZEBIEG BADANIA', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
      p2Header(1, 'DANE Z WYWIADU BEZPOREDNIEGO I OBSERWACJI OSOBY BADANEJ'),
    ],
  );
}
