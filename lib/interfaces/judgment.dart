abstract class Judgment {
  final String judgmentName;
  final String number;
  final String article;
  final String patientName;
  final String document;
  final String residence;
  final String state;
  final String termOfValidyty;
  final String dateOfIssue;
  final bool carA;
  final bool carB;
  final bool carC;
  final String pdf;

  Judgment({
    required this.judgmentName,
    required this.number,
    required this.article,
    required this.patientName,
    required this.document,
    required this.residence,
    required this.state,
    required this.carA,
    required this.carB,
    required this.carC,
    required this.termOfValidyty,
    required this.dateOfIssue,
    required this.pdf,
  });

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['judgmentName'] = judgmentName;
    json['number'] = number;
    json['article'] = article;
    json['patientName'] = patientName;
    json['document'] = document;
    json['residence'] = residence;
    json['state'] = state;
    json['carA'] = carA;
    json['carB'] = carB;
    json['carC'] = carC;
    json['termOfValidyty'] = termOfValidyty;
    json['dateOfIssue'] = dateOfIssue;
    json['pdf'] = pdf;

    return json;
  }
}
