class Judgment {
  String judgmentName;
  String number;
  String article;
  String patientName;
  String document;
  String residence;
  String state;
  String termOfValidyty;
  String dateOfIssue;
  bool carA;
  bool carB;
  bool carC;
  String pdf;

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

  factory Judgment.fromJson(Map<String, dynamic> json) {
    return Judgment(
      judgmentName: json['judgmentName'],
      number: json['number'],
      article: json['article'],
      patientName: json['patientName'],
      document: json['document'],
      residence: json['residence'],
      state: json['state'],
      carA: json['carA'],
      carB: json['carB'],
      carC: json['carC'],
      termOfValidyty: json['termOfValidyty'],
      dateOfIssue: json['dateOfIssue'],
      pdf: json['pdf'],
    );
  }

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
