import 'package:e_rejestr/pdf/karta_kz/p1_right_size.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget medicalHeader(String date, {bool showCity = true, bool type = false, String typeText = 'Wstępne'}) {
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
      showCity
          ? pw.Column(
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
            )
          : pw.Container(),
      type
          ? pw.Column(
              children: [
                pw.Text(
                  'odzaj badania lekarskiego:',
                  style: const pw.TextStyle(fontSize: 8),
                ),
                pw.RichText(
                  text: pw.TextSpan(
                    text: 'Wstępne/',
                    style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold, decoration: typeText == 'Wstępne' ? null : pw.TextDecoration.lineThrough),
                    children: [
                      pw.TextSpan(
                        text: 'okresowe/',
                        style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold, decoration: typeText == 'okresowe' ? null : pw.TextDecoration.lineThrough),
                      ),
                      pw.TextSpan(
                        text: 'kontrolne',
                        style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold, decoration: typeText == 'kontrolne' ? null : pw.TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : pw.Container()
    ],
  );
}
