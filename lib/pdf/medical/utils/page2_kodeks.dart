import 'package:e_rejestr/pdf/medical/utils/explantions_kodeks.dart';
import 'package:e_rejestr/pdf/medical/utils/instructions_kodeks.dart';
import 'package:e_rejestr/pdf/medical/utils/symbols.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Widget page2Kodeks() {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      instructionsKodeks(),
      symbols(),
      explanationsKodeks(),
    ],
  );
}
