import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/medical_judgment.dart';
import 'package:e_rejestr/models/medicine.dart';
import 'package:e_rejestr/models/register.dart';
import 'package:e_rejestr/pdf/karta_kz/p1_right_size.dart';
import 'package:e_rejestr/pdf/register.dart';
import 'package:e_rejestr/utils/files.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RegisterPrint extends ChangeNotifier {
  var startDate = DateTime(DateTime.now().year, 1, 1);
  var endDate = DateTime.now();
  var loaded = false;

  String getFormatedDate(DateTime date) {
    final format = new DateFormat('dd-MM-yyyy');
    return format.format(date);
  }

  Future<void> generateRegister(DocumentType documentType, BuildContext context) async {
    loaded = true;
    notifyListeners();
    late List<Register> registerList;

    if (documentType == DocumentType.medical) {
      registerList = await _getMedicalJudgment();
    } else {
      registerList = await _getPsychoJudgment();
      print("sadffsa ${registerList.length}");
    }

    var file = await generatePDF(registerList);
    loaded = false;
    notifyListeners();
    // ignore: use_build_context_synchronously
    printPDF(file, context);
    // TODO ZROBIĆ GENEROWANIE PDF DLA REJESTRU
  }

  Future<List<Register>> _getMedicalJudgment() async {
    List<Register> registers = [];

    var documents = await Firestore.instance.collection(Collection.kartKzMedical.name).get(pageSize: 2048);
    for (var element in documents) {
      List<MedicaJudgmentInterface> listOfJudgment = (element.map['judgments'] as List<dynamic>).map((e) => e['judgmentName'] == medicalMedycynaPracy || e['judgmentName'] == medicalMedycynaPracyInstruktor ? Medicine.fromJson(e) : MedicalJudgment.fromJson(e)).toList();
      var articles = listOfJudgment.map((e) => e.article).toList();

      for (var judgment in listOfJudgment) {
        var json = await Register.convertMedicalJudgmentToRegister(patientId: element.map['patientId'], judgment: judgment, articles: articles);
        var register = Register.fromJson(json);
        var splits = judgment.dateOfIssue.split('-');
        var judgmentDate = DateTime(int.parse(splits[2]), int.parse(splits[1]), int.parse(splits[0]), 0, 0, 1);

        if (judgmentDate.isAfter(startDate) && judgmentDate.isBefore(endDate)) {
          registers.add(register);
        }
      }
    }

    registers.sort((a, b) => sortRegister(a, b));

    return registers;
  }

  Future<List<Register>> _getPsychoJudgment() async {
    List<Register> registers = [];

    var documents = await Firestore.instance.collection(Collection.kartKzPsycho.name).get();

    for (var element in documents) {
      var listOfJudgment = (element.map['judgments'] as List<dynamic>).map((e) => Judgment.fromJson(e)).toList();
      var articles = listOfJudgment.map((e) => e.article).toList();
      for (var judgment in listOfJudgment) {
        var json = await Register.convertPsychologicalJudgmentToRegister(patientId: element.map['patientId'], judgment: judgment, articles: articles);
        var register = Register.fromJson(json);
        var splits = judgment.dateOfIssue.split('-');
        var judgmentDate = DateTime(int.parse(splits[2]), int.parse(splits[1]), int.parse(splits[0]), 0, 0, 1);

        if (judgmentDate.isAfter(startDate) && judgmentDate.isBefore(endDate)) {
          registers.add(register);
        }
      }
    }

    registers.sort((a, b) => sortRegister(a, b));

    return registers;
  }

  Future<Uint8List> generatePDF(List<Register> registers) async {
    var font = await rootBundle.load("fonts/Lato-Regular.ttf");
    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle.load("fonts/Lato-Regular.ttf")),
      bold: pw.Font.ttf(await rootBundle.load("fonts/Lato-Bold.ttf")),
    );
    pw.Font.ttf(font);

    var pdf = pw.Document(theme: myTheme);
    var limit = 8;
    var pages = (registers.length / limit);

    for (int i = 0; i < pages; i++) {
      var initialOffset = i * limit;

      var tmpRegisters = pagination(registers, initialOffset, limit);

      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(15),
          pageFormat: PdfPageFormat.a4,
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return register(registers: tmpRegisters.toList());
          },
        ),
      );
    }
    return await pdf.save();
  }

  void printPDF(Uint8List file, BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: PdfPreview(
              build: (format) => file,
            ),
          );
        });
  }

  Iterable<Register> pagination(List<Register> registers, int offset, int limit) {
    try {
      return registers.getRange(offset, 8);
    } on RangeError catch (error) {
      var end = error.end as int;
      return registers.getRange(offset, end);
    }
  }
}
