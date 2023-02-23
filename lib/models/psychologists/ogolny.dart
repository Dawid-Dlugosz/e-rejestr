import 'package:e_rejestr/interfaces/judgment.dart';

class Ogolny extends Judgment {
  Ogolny({
    required super.judgmentName,
    required super.number,
    required super.article,
    required super.patientName,
    required super.document,
    required super.residence,
    required super.state,
    required super.carA,
    required super.carB,
    required super.carC,
    required super.termOfValidyty,
    required super.dateOfIssue,
    required super.pdf,
  });

  factory Ogolny.fromJson(Map<String, dynamic> json) {
    return Ogolny(
      judgmentName: json['judgmentName'],
      number: json['number'],
      article: json['article'],
      patientName: json['patientName'],
      document: json['document'],
      residence: json['residence'],
      state: json['state'],
      carA: json['carA'],
      carB: json['carB'],
      carC: json['carB'],
      termOfValidyty: json['termOfValidyty'],
      dateOfIssue: json['dateOfIssue'],
      pdf: json['pdf'],
    );
  }
}
