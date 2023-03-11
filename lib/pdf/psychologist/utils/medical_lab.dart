import 'package:pdf/widgets.dart' as pw;

pw.Widget medicalLab() {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Column(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Text(
          '............................................................',
          style: const pw.TextStyle(fontSize: 11),
        ),
        pw.Text(
          '(określenie pracowni psychologicznej*)',
          style: const pw.TextStyle(fontSize: 8),
        ),
      ],
    ),
  );
}
