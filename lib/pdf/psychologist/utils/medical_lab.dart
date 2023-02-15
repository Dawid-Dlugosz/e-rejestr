import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget medicalLab() {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Column(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Text(
          '............................................................',
          style: pw.TextStyle(fontSize: 11),
        ),
        pw.Text(
          '(określenie pracowni psychologicznej*)',
          style: pw.TextStyle(fontSize: 8),
        ),
      ],
    ),
  );
}
