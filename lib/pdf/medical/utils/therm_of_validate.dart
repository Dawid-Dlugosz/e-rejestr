import 'package:pdf/widgets.dart' as pw;

pw.Widget thermOfValidate(String date) {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Container(
      margin: const pw.EdgeInsets.only(top: 20),
      child: pw.Row(
        children: [
          pw.Text('Termin następnego badania', style: const pw.TextStyle(fontSize: 12)),
          pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                date,
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                '.......................................................................',
                style: const pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
