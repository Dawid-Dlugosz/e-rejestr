import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget explantios() {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 10),
          child: pw.Text(
            'Objaśnienia:',
            style: const pw.TextStyle(fontSize: 10),
          ),
        ),
        pw.RichText(
          text: const pw.TextSpan(
            text: '1)',
            style: pw.TextStyle(fontSize: 9),
            baseline: 6,
            children: [
              pw.TextSpan(
                text: ' Niepotrzebne skreślić.',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        pw.RichText(
          text: const pw.TextSpan(
            text: '2)',
            style: pw.TextStyle(fontSize: 9),
            baseline: 6,
            children: [
              pw.TextSpan(
                text: ' Zaznaczyć właściwe poprzez umieszczenie znaku X w odpowiednim polu przy właściwej grupie kategorii prawa jazdy. Pozostałe grupy kategorii prawa jazdy należy skreślić. Nie określa się żadnej kategorii w ramach grupy kategorii prawa jazdy, przy której został zamieszczony znak X.',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        pw.RichText(
          text: const pw.TextSpan(
            text: '3)',
            style: pw.TextStyle(fontSize: 9),
            baseline: 6,
            children: [
              pw.TextSpan(
                text: ' Dotyczy jedynie przypadków, o których mowa w art. 3 ust. 3a ustawy z dnia 5 stycznia 2011 r. o kierujących pojazdami.',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        pw.RichText(
          text: const pw.TextSpan(
            text: '4)',
            style: pw.TextStyle(fontSize: 9),
            baseline: 6,
            children: [
              pw.TextSpan(
                text: ' Wpisać właściwe kody i subkody określone w przepisach wydanych na podstawie art. 20 ust.1 pkt 1 ustawy z dnia 5 stycznia 2011 r. o kierujących pojazdami. Kody należy oddzielić znakiem „/”.',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        pw.RichText(
          text: const pw.TextSpan(
            text: '5)',
            style: pw.TextStyle(fontSize: 9),
            baseline: 6,
            children: [
              pw.TextSpan(
                text: '  Skreślić w przypadku orzeczenia lekarskiego wydanego w trybie odwoławczym.',
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
