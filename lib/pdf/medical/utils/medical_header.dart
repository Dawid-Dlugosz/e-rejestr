import 'package:pdf/widgets.dart' as pw;

pw.Widget medicalHeader(String date, {bool showCity = true, bool type = false, String typeText = 'Wstępne'}) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Column(
        children: [
          pw.Text(
            '……………………………………………',
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.Text(
            '(oznaczenie jednostki przeprowadzającej badanie lekarskie)',
            style: const pw.TextStyle(fontSize: 8),
          ),
        ],
      ),
      pw.Spacer(),
      showCity
          ? pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'Łuków $date',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  '(miejscowość, data)',
                  style: const pw.TextStyle(fontSize: 8),
                ),
              ],
            )
          : pw.Container(),
      type
          ? pw.Column(
              children: [
                pw.Text(
                  'odzaj badania lekarskiego:',
                  style: const pw.TextStyle(fontSize: 8),
                ),
                pw.RichText(
                  text: pw.TextSpan(
                    text: '',
                    children: [
                      pw.TextSpan(
                        text: 'Wstępne/',
                        style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold, decoration: typeText == 'Wstępne' ? null : pw.TextDecoration.lineThrough),
                      ),
                      pw.TextSpan(
                        text: 'okresowe/',
                        style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold, decoration: typeText == 'Okresowe' ? null : pw.TextDecoration.lineThrough),
                      ),
                      pw.TextSpan(
                        text: 'kontrolne',
                        style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold, decoration: typeText == 'Kontrolne' ? null : pw.TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : pw.Container()
    ],
  );
}
