import 'package:pdf/widgets.dart' as pw;

pw.Widget symbols() {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'Symbole rodzaju orzeczenia :',
        style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
      ),
      pw.Text(
        '21 - wobec braku przeciwwskazań zdrowotnych zdolny do wykonywania pracy na wskazanym (dotychczasowym) stanowisku pracy',
        style: const pw.TextStyle(fontSize: 12),
      ),
      pw.Text(
        '22 - wobec przeciwwskazań zdrowotnych niezdolny do wykonywania pracy na wskazanym (dotychczasowym)stanowisku pracy',
        style: const pw.TextStyle(fontSize: 12),
      ),
      pw.Text(
        '23 - wobec przeciwwskazań zdrowotnych utracił zdolność do wykonywania dotychczasowej pracy',
        style: const pw.TextStyle(fontSize: 12),
      ),
    ],
  );
}
