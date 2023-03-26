abstract class MedicaJudgmentInterface {
  MedicaJudgmentInterface({
    required this.article,
    required this.judgmentName,
    required this.dateOfIssue,
    required this.dateOfValidity,
    required this.pdf,
    required this.number,
  });

  final String article;
  final String judgmentName;
  final String dateOfIssue;
  String dateOfValidity;
  final String pdf;
  String number;
}
