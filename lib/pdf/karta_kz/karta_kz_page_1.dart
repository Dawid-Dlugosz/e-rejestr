import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/pdf/karta_kz/p1_left_side.dart';
import 'package:e_rejestr/pdf/karta_kz/p1_right_size.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget karta_kz_page_1({required Patient patient, required String dateOfIssue, required String nrRej}) {
  return pw.LayoutBuilder(builder: (context, constraint) {
    return pw.Container(
      color: PdfColor.fromHex('#ec9b4c'),
      width: constraint!.maxWidth / 2,
      child: pw.Row(
        children: [
          p1_left_side(),
          p1_right_side(
            dateOfIssue: dateOfIssue,
            patient: patient,
            nrRej: nrRej,
          ),
        ],
      ),
    );
  });
}
