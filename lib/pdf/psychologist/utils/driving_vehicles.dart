import 'package:pdf/widgets.dart' as pw;

pw.Widget drivingVehicles({bool a = false, bool b = false, bool c = false}) {
  return pw.Align(
    alignment: pw.Alignment.centerLeft,
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('1) pojazdem w zakresie prawa jazdy kategorii:', style: const pw.TextStyle(fontSize: 11)),
        pw.Text('a) [${a ? 'x' : ''}] AM, A1, A2, A, B1, B, B+E, T,', style: pw.TextStyle(fontSize: 11, decoration: a ? null : pw.TextDecoration.lineThrough)),
        pw.Text('b) [${b ? 'x' : ''}] C1, C1+E, C, C+E, D1, D1+E, D, D+E;', style: pw.TextStyle(fontSize: 11, decoration: b ? null : pw.TextDecoration.lineThrough)),
        pw.Text('2) [${c ? 'x' : ''}] tramwajem**).', style: pw.TextStyle(fontSize: 11, decoration: c ? null : pw.TextDecoration.lineThrough)),
      ],
    ),
  );
}
