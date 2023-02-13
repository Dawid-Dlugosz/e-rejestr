import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget patientName(String patientName) {
  return pw.Row(
    children: [
      pw.Text('u Pani/Pana**)', style: pw.TextStyle(fontSize: 11)),
      pw.SizedBox(
        width: 10,
      ),
      pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Text(
            patientName,
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            '...............................................................................................................................................................................................................................',
            style: pw.TextStyle(fontSize: 8),
          ),
          pw.Text(
            '(imię i nazwisko)',
            style: pw.TextStyle(fontSize: 8),
          )
        ],
      )
    ],
  );
}
