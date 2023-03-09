import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/patient.dart';

class KartaKz {
  KartaKz({
    required this.uid,
    required this.patient,
    required this.number,
    required this.judgments,
  });

  final String uid;
  final Patient patient;
  final String number;
  final List<Judgment> judgments;

  factory KartaKz.fromJson(Map<String, dynamic> json) {
    return KartaKz(
      uid: json['uid'],
      patient: json['patient'],
      number: json['number'],
      judgments: (json['judgments'] as List<dynamic>).map((e) => Judgment.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['uid'] = uid;
    json['patient'] = patient.toJson();
    json['number'] = number;
    json['judgments'] = judgments.map((e) => e.toJson()).toList();

    return json;
  }
}
