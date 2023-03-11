import 'package:pdf/widgets.dart' as pw;

pw.Widget judgmentDate(String stars) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Container(
        width: 20,
        child: pw.Text('$stars)', style: const pw.TextStyle(fontSize: 8)),
      ),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Orzeczenie jest wydane na okres, o którym mowa w art. 13 ust.1 pkt 2 oraz art. 16 ust. 3 ustawy z dnia 5\nstycznia 2011 r. o kierujących pojazdami.', style: const pw.TextStyle(fontSize: 8)),
        ],
      ),
    ],
  );
}
