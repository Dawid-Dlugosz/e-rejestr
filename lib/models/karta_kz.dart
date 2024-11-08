import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:firedart/firedart.dart';

class KartaKz {
  KartaKz({
    required this.uid,
    required this.patientId,
    required this.number,
    required this.judgments,
  });

  final String uid;
  final String patientId;
  final String number;
  final List<Judgment> judgments;

  factory KartaKz.fromJson(Map<String, dynamic> json) {
    return KartaKz(
      uid: json['uid'],
      patientId: json['patientId'],
      number: json['number'],
      judgments: (json['judgments'] as List<dynamic>).map((e) => Judgment.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['uid'] = uid;
    json['patientId'] = patientId;
    json['number'] = number;
    json['judgments'] = judgments.map((e) => e.toJson()).toList();

    return json;
  }

  static Future<KartaKz> getByNumber(String number) async {
    var documents = await Firestore.instance.collection(Collection.kartKzPsycho.name).where('number', isEqualTo: number).get();
    var map = documents.first.map;

    return KartaKz.fromJson(map);
  }
}
