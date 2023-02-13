import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget cailRow(String title) {
  return pw.Container(
    child: pw.Column(
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 8),
        ),
      ],
    ),
  );
}
