import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget residence(String residence) {
  return pw.Row(
    children: [
      pw.Text(
        'zamieszkałego(-ej)',
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
            residence,
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            '.......................................................................................................................................................................................................',
            style: pw.TextStyle(fontSize: 8),
          ),
          pw.Text(
            '(miejscowość, ulica, nr domu i nr lokalu)',
            style: pw.TextStyle(fontSize: 8),
          )
        ],
      )
    ],
  );
}
