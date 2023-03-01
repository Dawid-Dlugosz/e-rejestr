import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget patientResidenceKodeks(String residence) {
  return pw.Column(
    mainAxisSize: pw.MainAxisSize.min,
    mainAxisAlignment: pw.MainAxisAlignment.start,
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Row(
        children: [
          pw.Text(
            'zamieszkały(-ła) w',
            style: pw.TextStyle(fontSize: 11),
          ),
          pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                residence,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                '..................................................................................................................................................................................',
                style: pw.TextStyle(fontSize: 8),
              ),
              pw.Text(
                '(miejscowość, ulica, nr domu, nr lokalu)',
                style: pw.TextStyle(fontSize: 8),
              )
            ],
          )
        ],
      ),
    ],
  );
}
