import 'package:e_rejestr/pdf/karta_kz/p1_right_size.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget medicalHeader(String date) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Column(
        children: [
          pw.Text(
            '……………………………………………',
            style: pw.TextStyle(fontSize: 12),
          ),
          pw.Text(
            '(oznaczenie jednostki przeprowadzającej badanie lekarskie)',
            style: pw.TextStyle(fontSize: 8),
          ),
        ],
      ),
      pw.Spacer(),
      pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Text(
            'Łuków $date',
            style: pw.TextStyle(fontSize: 12),
          ),
          pw.Text(
            '(miejscowość, data)',
            style: pw.TextStyle(fontSize: 8),
          ),
        ],
      ),
    ],
  );
}
