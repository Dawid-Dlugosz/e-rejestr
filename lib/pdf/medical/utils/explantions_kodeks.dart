import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget explanationsKodeks() {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'Objaśnienia:',
        style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
      ),
      pw.Text(
        '*) Niepotrzebne skreślić.',
        style: const pw.TextStyle(fontSize: 12),
      ),
      pw.Text(
        '**) W przypadku osoby nieposiadającej numeru PESEL – seria, numer i nazwa dokumentu potwierdzającego tożsamość.',
        style: const pw.TextStyle(fontSize: 12),
      ),
      pw.Text(
        '***) Skreślić w przypadku orzeczenia lekarskiego wydanego w trybie odwoławczym',
        style: const pw.TextStyle(fontSize: 12),
      ),
    ],
  );
}
