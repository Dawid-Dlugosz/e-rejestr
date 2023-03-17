import 'package:e_rejestr/pdf/karta_kz/p2_left_side.dart';
import 'package:e_rejestr/pdf/karta_kz/p2_right_side.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget karta_kz_page_2() {
  return pw.LayoutBuilder(builder: (context, constraint) {
    return pw.Container(
      width: constraint!.maxWidth / 2,
      child: pw.Row(
        children: [
          p2_left_side(),
          p2_right_side(),
        ],
      ),
    );
  });
}
