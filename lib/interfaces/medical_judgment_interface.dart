import 'package:e_rejestr/models/patient.dart';

abstract class MedicaJudgmentInterface {
  MedicaJudgmentInterface({required this.article, required this.judgmentName, required this.dateOfIssue, required this.dateOfValidity, required this.pdf, required this.patient, required this.number});

  final String article;
  final String judgmentName;
  final String dateOfIssue;
  String dateOfValidity;
  final String pdf;
  Patient patient;
  String number;
}
