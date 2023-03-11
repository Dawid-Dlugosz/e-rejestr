import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/firm.dart';

class Medicine extends MedicaJudgmentInterface {
  Medicine({
    required this.firm,
    required super.judgmentName,
    required super.pdf,
    required super.article,
    required super.dateOfIssue,
    required super.dateOfValidity,
    required this.checkboxA,
    required this.checkboxB,
    required this.checkboxC,
    required this.typeMedical,
    required super.patient,
    required super.number,
    required this.checkboxCDate,
    required this.workPosition,
  });

  Firm firm;

  String typeMedical;
  bool checkboxA;
  bool checkboxB;
  bool checkboxC;
  String checkboxCDate;
  String workPosition;

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      firm: Firm.fromJson(json['firm']),
      judgmentName: json['judgmentName'],
      pdf: json['pdf'],
      article: json['article'],
      dateOfIssue: json['dateOfIssue'],
      dateOfValidity: json['dateOfValidity'],
      checkboxA: json['checkboxA'],
      checkboxB: json['checkboxB'],
      checkboxC: json['checkboxC'],
      typeMedical: json['typeMedical'],
      patient: json['patient'],
      number: json['number'],
      checkboxCDate: json['checkboxCDate'],
      workPosition: json['workPosition'],
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['firm'] = firm.toJson();
    json['judgmentName'] = judgmentName;
    json['pdf'] = pdf;
    json['article'] = article;
    json['dateOfIssue'] = dateOfIssue;
    json['dateOfValidity'] = dateOfValidity;
    json['checkboxA'] = checkboxA;
    json['checkboxB'] = checkboxB;
    json['checkboxC'] = checkboxC;
    json['typeMedical'] = typeMedical;
    json['patient'] = patient.toJson();
    json['number'] = number;
    json['checkboxCDate'] = checkboxCDate;
    json['workPosition'] = workPosition;

    return json;
  }
}
