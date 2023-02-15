import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget cailHeader(String title, {double? width, double padding = 2}) {
  return pw.Container(
    width: width,
    decoration: pw.BoxDecoration(
      border: pw.Border.all(),
    ),
    padding: pw.EdgeInsets.all(padding),
    child: pw.Text(
      title.toUpperCase(),
      style: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: 8,
      ),
      textAlign: pw.TextAlign.center,
    ),
  );
}
