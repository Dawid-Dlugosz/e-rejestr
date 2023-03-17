import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/karta_kz.dart';
import 'package:e_rejestr/models/karta_kz_medical.dart';
import 'package:e_rejestr/models/medical_judgment.dart';
import 'package:e_rejestr/models/medicine.dart';
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

  static Map<String, dynamic> converJugmnetToRightPdf(Map<String, dynamic> json, DocumentType document) {
    if (document == DocumentType.medical) {
      var kartaKz = KartaKzMedical.fromJson(json);

      var jsonMap = <String, dynamic>{};

      jsonMap['lp'] = kartaKz.number;
      jsonMap['address'] = kartaKz.patient.residentialAddress.toJson();
      jsonMap['documentNumber'] = kartaKz.patient.getDocument();

      List<String> articles = [];
      for (var element in kartaKz.judgments) {
        articles.add(element.article);
      }
      jsonMap['articles'] = articles.map((e) => e).toList();
      jsonMap['releaseDate'] = kartaKz.number;
      jsonMap['fullName'] = kartaKz.patient.getFullName();
      return jsonMap;
    }

    var kartaKz = KartaKz.fromJson(json);

    var jsonMap = <String, dynamic>{};

    jsonMap['lp'] = kartaKz.number;
    jsonMap['address'] = kartaKz.patient.residentialAddress.toJson();
    jsonMap['documentNumber'] = kartaKz.patient.getDocument();

    List<String> articles = [];
    for (var element in kartaKz.judgments) {
      articles.add(element.article);
    }
    jsonMap['articles'] = articles.map((e) => e).toList();
    jsonMap['releaseDate'] = kartaKz.number;
    jsonMap['fullName'] = kartaKz.patient.getFullName();

    return jsonMap;
  }
}
