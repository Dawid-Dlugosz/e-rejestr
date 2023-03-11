import 'package:pdf/widgets.dart' as pw;

pw.Widget medical_title({required String number}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(top: 20, bottom: 5),
    child: pw.Text(
      'ORZECZENIE LEKARSKIE NR: $number',
      style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
    ),
  );
}
