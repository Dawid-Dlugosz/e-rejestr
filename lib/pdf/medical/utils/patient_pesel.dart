import 'package:pdf/widgets.dart' as pw;

pw.Widget patientPesel(String pesel) {
  return pw.Column(
    mainAxisSize: pw.MainAxisSize.min,
    mainAxisAlignment: pw.MainAxisAlignment.start,
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'numer PESEL, a w przypadku osoby, której nie nadano numeru PESEL – nazwa i numer',
        style: const pw.TextStyle(fontSize: 11),
      ),
      pw.Row(
        children: [
          pw.Text(
            'dokumentu stwierdzającego tożsamość',
            style: const pw.TextStyle(fontSize: 11),
          ),
          pw.SizedBox(
            width: 10,
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
