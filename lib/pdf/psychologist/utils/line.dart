import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget line({double? width, bool margin = true}) {
  return pw.Container(
    width: width != null ? width : double.infinity,
    margin: margin ? pw.EdgeInsets.symmetric(vertical: 20) : null,
    height: 2,
    color: PdfColor.fromHex('#000000'),
  );
}
