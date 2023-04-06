import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/medical_judgment.dart';
import 'package:e_rejestr/models/medicine.dart';
import 'package:e_rejestr/models/register.dart';
import 'package:e_rejestr/pdf/karta_kz/p1_right_size.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterPrint extends ChangeNotifier {
  var startDate = DateTime(DateTime.now().year, 1, 1);
  var endDate = DateTime.now();
  var loaded = false;
  String getFormatedDate(DateTime date) {
    final format = new DateFormat('dd-MM-yyyy');
    return format.format(date);
  }

  Future<List<Register>> generateRegister(DocumentType documentType) async {
    loaded = true;
    notifyListeners();

    if (documentType == DocumentType.medical) {
      var registerList = await _getMedicalJudgment();
      loaded = false;
      notifyListeners();

      return registerList;
    } else {
      var registerList = await _getPsychoJudgment();
      loaded = false;
      notifyListeners();
      return registerList;
    }

    // TODO STOWRZYC SZABLON DLA REJESRU
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
    documents.map((element) async {
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
    });

    registers.sort((a, b) => sortRegister(a, b));

    return registers;
  }
}
