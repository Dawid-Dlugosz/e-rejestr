import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget dataOfIssue(String date) {
  return pw.Container(
    margin: pw.EdgeInsets.only(top: 50),
    padding: pw.EdgeInsets.symmetric(horizontal: 20),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          children: [
            pw.Text(date, style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
            pw.Text('(data wystawienia)', style: pw.TextStyle(fontSize: 8)),
          ],
        ),
        pw.Column(
          children: [
            pw.Text('..............................................', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
            pw.Text('(informacje o uprawnionym psychologu oraz jego podpis ***))', style: pw.TextStyle(fontSize: 8)),
          ],
        )
      ],
    ),
  );
}
