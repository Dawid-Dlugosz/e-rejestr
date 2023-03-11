import 'package:pdf/widgets.dart' as pw;

pw.Widget textField(String name) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 10),
        child: pw.Text(
          name,
          style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.Container(
        height: 140,
        width: 400,
        decoration: pw.BoxDecoration(border: pw.Border.all()),
      ),
    ],
  );
}
