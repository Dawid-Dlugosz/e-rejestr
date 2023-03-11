import 'package:pdf/widgets.dart' as pw;

pw.Widget cars_uprzywilejowany({bool a = false, bool b = false, bool c = false, bool d = false}) {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.RichText(
          text: const pw.TextSpan(
            text: '1) prawo jazdy kategorii: ',
            style: pw.TextStyle(fontSize: 10),
            children: [
              pw.TextSpan(
                text: ' 2) ',
                baseline: 6,
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        pw.Text(
          '1) [${a ? 'x' : ''}] AM, A1, A2, A, B1, B, B+E, T,',
          style: pw.TextStyle(fontSize: 11, decoration: a ? null : pw.TextDecoration.lineThrough),
        ),
        pw.Text(
          '2) [${b ? 'x' : ''}] C1, C1+E, C, C+E, D1, D1+E, D, D+E;',
          style: pw.TextStyle(fontSize: 11, decoration: b ? null : pw.TextDecoration.lineThrough),
        ),
        pw.Text(
          '3) [${c ? 'x' : ''}] C1, C1+E, C, C+E;',
          style: pw.TextStyle(fontSize: 11, decoration: c ? null : pw.TextDecoration.lineThrough),
        ),
        pw.Text(
          '4) [${d ? 'x' : ''}] pozwolenie na kierowanie tramwajem.',
          style: pw.TextStyle(fontSize: 11, decoration: d ? null : pw.TextDecoration.lineThrough),
        ),
      ],
    ),
  );
}
