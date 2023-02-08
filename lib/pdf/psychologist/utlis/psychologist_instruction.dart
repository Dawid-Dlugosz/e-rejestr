import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget psychologistInstruction(String stars) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Container(
        width: 20,
        child: pw.Text(stars, style: pw.TextStyle(fontSize: 8)),
      ),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Należy podać:', style: pw.TextStyle(fontSize: 8)),
          pw.Text('- imię i nazwisko uprawnionego psychologa', style: pw.TextStyle(fontSize: 8)),
          pw.Text('- numer wpisu do ewidencji uprawnionych psychologów oraz oznaczenie podmiotu prowadzącego ewidencję.', style: pw.TextStyle(fontSize: 8)),
        ],
      ),
    ],
  );
}
