import 'package:pdf/widgets.dart' as pw;

pw.Widget work(String work) {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Column(
      children: [
        pw.Text(
          'zatrudniony(-na) / przyjmowany(-na)*)  do pracy w: ',
          style: const pw.TextStyle(fontSize: 11),
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          work,
          style: pw.TextStyle(
            fontSize: 11,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          '(nazwa i adres pracodawcy)',
          style: const pw.TextStyle(fontSize: 8),
        ),
      ],
    ),
  );
}
