import 'package:pdf/widgets.dart' as pw;

pw.Widget deleteInstruction(String stars) {
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
          pw.Text('Niepotrzebne skreślić.', style: const pw.TextStyle(fontSize: 8)),
        ],
      ),
    ],
  );
}
