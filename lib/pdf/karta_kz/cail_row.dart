import 'package:e_rejestr/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget cailRow(
  String title, {
  double height = 30,
  double? width,
  double padding = 2,
  String? text,
}) {
  return pw.Container(
    padding: pw.EdgeInsets.all(padding),
    width: width,
    height: height,
    decoration: pw.BoxDecoration(
      border: pw.Border.all(),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontSize: 8),
        ),
        text != null
            ? pw.Padding(
                padding: const pw.EdgeInsets.only(top: 5),
                child: pw.Text(
                  text,
                  style: pw.TextStyle(fontSize: 8),
                ))
            : pw.Container(),
      ],
    ),
  );
}
