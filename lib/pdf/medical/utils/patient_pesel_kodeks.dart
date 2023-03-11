import 'package:pdf/widgets.dart' as pw;

pw.Widget patientPeselKodeks(String pesel) {
  return pw.Column(
    mainAxisSize: pw.MainAxisSize.min,
    mainAxisAlignment: pw.MainAxisAlignment.start,
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Row(
        children: [
          pw.Text(
            'nr PESEL **)',
            style: const pw.TextStyle(fontSize: 11),
          ),
          pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(
                pesel,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                '..................................................................................................................................................................................',
                style: const pw.TextStyle(fontSize: 8),
              ),
            ],
          )
        ],
      ),
    ],
  );
}
