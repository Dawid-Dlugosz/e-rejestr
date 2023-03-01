import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget limitions(bool select1, bool select2) {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      pw.SizedBox(height: 10),
      pw.Text(
        '2) Ograniczenie w zakresie:',
        style: const pw.TextStyle(fontSize: 10),
      ),
      pw.Container(
        margin: const pw.EdgeInsets.only(left: 10),
        child: pw.RichText(
          text: const pw.TextSpan(
            text: '1) ',
            style: pw.TextStyle(fontSize: 11),
            children: [
              pw.TextSpan(
                text: 'pojazdów, którymi może kierować osoba badana, ich wyposażenia, oznakowania lub przystosowania',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
              pw.TextSpan(
                text: ' 4) ',
                baseline: 6,
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
              pw.TextSpan(
                text: ';',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ),
      pw.Container(
        margin: const pw.EdgeInsets.only(left: 10),
        child: pw.RichText(
          text: const pw.TextSpan(
            text: '2) ',
            style: pw.TextStyle(fontSize: 11),
            children: [
              pw.TextSpan(
                text: ' specjalnych wymagań wobec osoby kierującej pojazdem',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
              pw.TextSpan(
                text: ' 4) ',
                baseline: 6,
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
      pw.SizedBox(height: 10),
      pw.Text(
        '..........................................................................................................................................',
        style: const pw.TextStyle(fontSize: 10),
      )
    ]),
  );
}
