import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget disense(String title, String description) {
  return pw.Column(
    children: [
      pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 5),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(
              width: 120,
              child: pw.Text(
                title,
                style: pw.TextStyle(fontSize: 6, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Flexible(
              child: pw.Text(
                description,
                maxLines: 2,
                style: pw.TextStyle(fontSize: 6),
              ),
            )
          ],
        ),
      ),
      pw.Text('...................................................................................................................................................................................................................................................................................................................', style: pw.TextStyle(fontSize: 6))
    ],
  );
}
