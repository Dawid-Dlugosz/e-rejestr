import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget date_of_validyty_kodeks(String date) {
  return pw.RichText(
    text: pw.TextSpan(
      text: 'Data następnego badania okresowego zgodnie z art. 34 ust. 5 pkt.1/pkt2 ustawy z dnia 5 stycznia 2011r. o kierujących pojazdami: ',
      style: const pw.TextStyle(fontSize: 11),
      children: [
        pw.TextSpan(
          text: date,
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
