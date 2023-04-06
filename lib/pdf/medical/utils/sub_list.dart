import 'package:pdf/widgets.dart' as pw;

pw.Widget subList({
  required String number,
  required String text,
  bool sub = false,
}) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.SizedBox(
        width: sub ? 40 : 30,
      ),
      pw.Text(
        number,
        style: const pw.TextStyle(fontSize: 10),
      ),
      pw.SizedBox(
        width: 10,
      ),
      pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 10),
      ),
    ],
  );
}
