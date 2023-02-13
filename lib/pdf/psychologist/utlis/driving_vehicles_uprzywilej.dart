import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget drivingVehiclesUprzywilej({bool a = false, bool b = false, bool c = false}) {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('a) [${a ? 'x' : ''}] A1, A2, A', style: pw.TextStyle(fontSize: 11, decoration: a ? null : pw.TextDecoration.lineThrough)),
        pw.Text('b) [${b ? 'x' : ''}] B1, B2, B+E', style: pw.TextStyle(fontSize: 11, decoration: b ? null : pw.TextDecoration.lineThrough)),
        pw.Text('2) [${c ? 'x' : ''}] C1, C1+E, C, C+E, D1, D1+E, D, D+E **)', style: pw.TextStyle(fontSize: 11, decoration: c ? null : pw.TextDecoration.lineThrough)),
      ],
    ),
  );
}
