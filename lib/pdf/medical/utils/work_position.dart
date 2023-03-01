import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget workPosition(
  String workPosition, {
  required bool a,
  required bool b,
  required bool c,
  String? date,
}) {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'na stanowisku / stanowiskach / stanowisko / stanowiska*) ',
          style: const pw.TextStyle(fontSize: 11),
        ),
        pw.Text(
          workPosition,
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          '* wobec braku przeciwwskazań zdrowotnych jest zdolny(-na) do wykonywania/podjęcia*) pracy na określonym stanowisku (symbol 21)*)',
          style: pw.TextStyle(
            fontSize: 10,
            decoration: a ? null : pw.TextDecoration.lineThrough,
          ),
        ),
        pw.Text(
          '* wobec istnienia przeciwwskazań zdrowotnych jest niezdolny(-na) do wykonywania/podjęcia*) pracy na określonym stanowisku (symbol 22)*)',
          style: pw.TextStyle(
            fontSize: 10,
            decoration: b ? null : pw.TextDecoration.lineThrough,
          ),
        ),
        pw.Text(
          '* wobec stnienia przeciwwskazań zdrowotnych utracił(a) zdolność do wykonywania dotychczasowej pracy z dniem ${date ?? '.................................................................'} (symbol 23)*).',
          style: pw.TextStyle(
            fontSize: 10,
            decoration: c ? null : pw.TextDecoration.lineThrough,
          ),
        ),
      ],
    ),
  );
}
