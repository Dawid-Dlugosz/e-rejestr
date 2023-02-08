import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget pesel(String pesel) {
  return pw.Column(
    mainAxisSize: pw.MainAxisSize.min,
    mainAxisAlignment: pw.MainAxisAlignment.start,
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'nr PESEL, a w przypadku osoby, której nie nadano nr PESEL – nazwa i numer dokumentu ',
        style: pw.TextStyle(fontSize: 11),
      ),
      pw.Row(
        children: [
          pw.Text(
            'stwierdzającego tożsamość',
            style: pw.TextStyle(fontSize: 11),
          ),
          pw.SizedBox(
            width: 10,
          ),
          pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                pesel,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                '..............................................................................................................................................................................................................................................................',
                style: pw.TextStyle(fontSize: 8),
              ),
            ],
          )
        ],
      ),
    ],
  );
}
