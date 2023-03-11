import 'package:pdf/widgets.dart' as pw;

pw.Widget evidence({double margin = 200}) {
  return pw.Align(
    alignment: pw.Alignment.centerRight,
    child: pw.Container(
      margin: pw.EdgeInsets.only(top: margin),
      child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text(
          '......................................................................................................................................................',
          style: const pw.TextStyle(fontSize: 10),
        ),
        pw.Text(
          '(podpis,  imię   i   nazwisko   oraz   numer   wpisu   do ewidencji\nuprawnionych lekarzy i numer prawa wykonywania zawodu uprawnionego\nlekarza)',
          style: const pw.TextStyle(fontSize: 9),
        )
      ]),
    ),
  );
}
