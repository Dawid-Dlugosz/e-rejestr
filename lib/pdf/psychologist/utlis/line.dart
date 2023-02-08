import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget line() {
  return pw.Container(
    width: double.infinity,
    margin: pw.EdgeInsets.symmetric(vertical: 20),
    height: 2,
    color: PdfColor.fromHex('#000000'),
  );
}
