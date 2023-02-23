import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget p2Header(int number, String title) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 5),
    child: pw.Row(
      children: [
        pw.Text('$number.', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
        pw.SizedBox(width: 10),
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
      ],
    ),
  );
}
