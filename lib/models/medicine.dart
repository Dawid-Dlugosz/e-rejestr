import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';

class Medicine extends MedicaJudgmentInterface {
  Medicine({
    required super.judgmentName,
    required super.pdf,
    required super.article,
    required super.dateOfIssue,
    required super.dateOfValidity,
    required this.checkboxA,
    required this.checkboxB,
    required this.checkboxC,
    required this.typeMedical,
    required super.number,
    required this.checkboxCDate,
    required this.workPosition,
  });

  String typeMedical;
  bool checkboxA;
  bool checkboxB;
  bool checkboxC;
  String checkboxCDate;
  String workPosition;

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      judgmentName: json['judgmentName'],
      pdf: json['pdf'],
      article: json['article'],
      dateOfIssue: json['dateOfIssue'],
      dateOfValidity: json['dateOfValidity'],
      checkboxA: json['checkboxA'],
      checkboxB: json['checkboxB'],
      checkboxC: json['checkboxC'],
      typeMedical: json['typeMedical'],
      number: json['number'],
      checkboxCDate: json['checkboxCDate'],
      workPosition: json['workPosition'],
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['judgmentName'] = judgmentName;
    json['pdf'] = pdf;
    json['article'] = article;
    json['dateOfIssue'] = dateOfIssue;
    json['dateOfValidity'] = dateOfValidity;
    json['checkboxA'] = checkboxA;
    json['checkboxB'] = checkboxB;
    json['checkboxC'] = checkboxC;
    json['typeMedical'] = typeMedical;
    json['number'] = number;
    json['checkboxCDate'] = checkboxCDate;
    json['workPosition'] = workPosition;

    return json;
  }
}
