import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/karta_kz.dart';
import 'package:e_rejestr/models/karta_kz_medical.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/models/residental_address.dart';

class Register {
  Register({
    required this.lp,
    required this.address,
    required this.documentNumber,
    required this.articles,
    required this.releaseDate,
    required this.fullName,
  });

  final String lp;
  final ResidentialAddress address;
  final String fullName;
  final String documentNumber;
  final List<String> articles;
  final String releaseDate;

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      lp: json['lp'],
      address: ResidentialAddress.fromJson(json['address']),
      fullName: json['fullName'],
      documentNumber: json['documentNumber'],
      articles: json['articles'],
      releaseDate: json['releaseDate'],
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['lp'] = lp;
    json['address'] = address;
    json['documentNumber'] = documentNumber;
    json['articles'] = articles;
    json['releaseDate'] = releaseDate;
    json['fullName'] = fullName;

    return json;
  }

  String getNameAndAddress() {
    return '${fullName} \n ${address.toString()}';
  }

  String getFormatedArticels() {
    return articles.join(', ');
  }

  static Future<Map<String, dynamic>> convertPsychologicalJudgmentToRegister({required String patientId, required Judgment judgment, required List<String> articles}) async {
    var jsonMap = <String, dynamic>{};
    var patient = await Patient.getPatientById(id: patientId);

    jsonMap['lp'] = judgment.number;
    jsonMap['address'] = patient.residentialAddress.toJson();
    jsonMap['documentNumber'] = patient.getDocument();
    jsonMap['articles'] = articles;
    jsonMap['releaseDate'] = judgment.dateOfIssue;
    jsonMap['fullName'] = patient.getFullName();

    return jsonMap;
  }

  static Future<Map<String, dynamic>> convertMedicalJudgmentToRegister({required String patientId, required MedicaJudgmentInterface judgment, required List<String> articles}) async {
    var jsonMap = <String, dynamic>{};

    var patient = await Patient.getPatientById(id: patientId);
    jsonMap['lp'] = judgment.number;
    jsonMap['address'] = patient.residentialAddress.toJson();
    jsonMap['documentNumber'] = patient.getDocument();
    jsonMap['articles'] = articles;
    jsonMap['releaseDate'] = judgment.dateOfIssue;
    jsonMap['fullName'] = patient.getFullName();

    return jsonMap;
  }

  static Future<Map<String, dynamic>> converJugmnetToRegister(Map<String, dynamic> json, DocumentType document) async {
    if (document == DocumentType.medical) {
      var kartaKz = KartaKzMedical.fromJson(json);

      var jsonMap = <String, dynamic>{};
      var patient = await Patient.getPatientById(id: kartaKz.patientId);

      jsonMap['lp'] = kartaKz.number;
      jsonMap['address'] = patient.residentialAddress.toJson();
      jsonMap['documentNumber'] = patient.getDocument();

      List<String> articles = [];
      for (var element in kartaKz.judgments) {
        articles.add(element.article);
      }
      jsonMap['articles'] = articles.map((e) => e).toList();
      jsonMap['releaseDate'] = kartaKz.judgments[0].dateOfIssue;
      jsonMap['fullName'] = patient.getFullName();

      return jsonMap;
    }

    var kartaKz = KartaKz.fromJson(json);

    var jsonMap = <String, dynamic>{};
    var patient = await Patient.getPatientById(id: kartaKz.patientId);

    jsonMap['lp'] = kartaKz.number;
    jsonMap['address'] = patient.residentialAddress.toJson();
    jsonMap['documentNumber'] = patient.getDocument();

    List<String> articles = [];
    for (var element in kartaKz.judgments) {
      articles.add(element.article);
    }
    jsonMap['articles'] = articles.map((e) => e).toList();
    jsonMap['releaseDate'] = kartaKz.judgments[0].dateOfIssue;
    jsonMap['fullName'] = patient.getFullName();

    return jsonMap;
  }
}
