import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';

class MedicalJudgment extends MedicaJudgmentInterface {
  MedicalJudgment({
    required this.state,
    required this.carA,
    required this.carB,
    required this.carC,
    required this.carD,
    required this.limitA,
    required this.limitB,
    required super.judgmentName,
    required super.article,
    required super.pdf,
    required super.dateOfIssue,
    required super.dateOfValidity,
    required super.number,
  });

  String state;
  bool carA;
  bool carB;
  bool carC;
  bool carD;
  bool limitA;
  bool limitB;

  factory MedicalJudgment.fromJson(Map<String, dynamic> json) {
    return MedicalJudgment(
      state: json['state'],
      carA: json['carA'],
      carB: json['carB'],
      carC: json['carC'],
      carD: json['carD'],
      limitA: json['limitA'],
      limitB: json['limitB'],
      dateOfValidity: json['dateOfValidity'],
      judgmentName: json['judgmentName'],
      dateOfIssue: json['dateOfIssue'],
      pdf: json['pdf'],
      article: json['article'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['state'] = state;
    json['carA'] = carA;
    json['carB'] = carB;
    json['carC'] = carC;
    json['carD'] = carD;
    json['limitA'] = limitA;
    json['limitB'] = limitB;
    json['dateOfValidity'] = dateOfValidity;
    json['judgmentName'] = judgmentName;
    json['dateOfIssue'] = dateOfIssue;
    json['pdf'] = pdf;
    json['article'] = article;
    json['number'] = number;

    return json;
  }
}
