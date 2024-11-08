import 'package:e_rejestr/pdf/medical/utils/explanations.dart';
import 'package:e_rejestr/pdf/medical/utils/instructions.dart';

import 'package:pdf/widgets.dart' as pw;

pw.Widget page2(String judgmentName) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      instructions(judgmentName),
      explantios(),
    ],
  );
}
