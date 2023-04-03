import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/medical_judgment.dart';
import 'package:e_rejestr/models/medicine.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:firedart/firedart.dart';

class KartaKzMedical {
  KartaKzMedical({
    required this.uid,
    required this.patientId,
    required this.number,
    required this.judgments,
    this.firmId,
  });

  final String uid;
  final String patientId;
  final String? firmId;
  final String number;
  final List<MedicaJudgmentInterface> judgments;

  factory KartaKzMedical.fromJson(Map<String, dynamic> json) {
    return KartaKzMedical(
      uid: json['uid'],
      patientId: json['patientId'],
      number: json['number'],
      firmId: json['firmId'],
      judgments: (json['judgments'] as List<dynamic>).map((e) => e['judgmentName'] == medicalMedycynaPracy || e['judgmentName'] == medicalMedycynaPracyInstruktor ? Medicine.fromJson(e) : MedicalJudgment.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['uid'] = uid;
    json['patientId'] = patientId;
    json['number'] = number;
    json['firmId'] = firmId;
    json['judgments'] = judgments.map((e) => e is Medicine ? e.toJson() : (e as MedicalJudgment).toJson()).toList();

    return json;
  }

  static Future<KartaKzMedical> getByNumber(String number) async {
    var documents = await Firestore.instance.collection(Collection.kartKzMedical.name).where('number', isEqualTo: number).get();
    var map = documents.first.map;

    return KartaKzMedical.fromJson(map);
  }
}
