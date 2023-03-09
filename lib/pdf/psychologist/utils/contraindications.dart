import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget contraindications(String state) {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.RichText(
      text: pw.TextSpan(
        text: 'stwierdzam ',
        style: pw.TextStyle(fontSize: 11, color: PdfColor.fromHex('#000000')),
        children: [
          pw.TextSpan(
            text: 'brak / ',
            style: pw.TextStyle(
              fontSize: 11,
              decoration: state == 'brak' ? null : pw.TextDecoration.lineThrough,
            ),
          ),
          pw.TextSpan(
            text: ' istnienie',
            style: pw.TextStyle(
              fontSize: 11,
              decoration: state == 'brak' ? pw.TextDecoration.lineThrough : null,
            ),
          ),
          const pw.TextSpan(
            text: '**) przeciwwskazań psychologicznych do wykonywania pracy na stanowisku kierowcy',
            style: pw.TextStyle(fontSize: 11),
          ),
        ],
      ),
    ),
  );
}
