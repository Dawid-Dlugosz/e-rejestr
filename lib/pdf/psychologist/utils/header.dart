import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget header(String number, {bool orginal = true}) {
  return pw.Column(
    mainAxisAlignment: pw.MainAxisAlignment.center,
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.SizedBox(
        height: 30,
      ),
      pw.Text(
        orginal ? 'orginał' : 'kopia',
        style: pw.TextStyle(fontSize: 11),
      ),
      pw.SizedBox(
        height: 15,
      ),
      pw.Text(
        'ORZECZENIE PSYCHOLOGICZNE  NR $number',
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
      ),
      pw.SizedBox(
        height: 15,
      ),
    ],
  );
}
