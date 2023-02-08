import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget contraindications() {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.RichText(
      text: pw.TextSpan(
        text: 'stwierdzam ',
        style: pw.TextStyle(fontSize: 11, color: PdfColor.fromHex('#000000')),
        children: const [
          pw.TextSpan(
            text: 'brak / ',
          ),
          pw.TextSpan(
            text: ' istnienie',
            style: pw.TextStyle(
              fontSize: 11,
              decoration: pw.TextDecoration.lineThrough,
            ),
          ),
          pw.TextSpan(text: '**) przeciwwskazań psychologicznych do wykonywania pracy na stanowisku kierowcy', style: pw.TextStyle(fontSize: 11)),
        ],
      ),
    ),
  );
}
