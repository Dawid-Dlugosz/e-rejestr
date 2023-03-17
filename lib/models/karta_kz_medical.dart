import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/medical_judgment.dart';
import 'package:e_rejestr/models/medicine.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/utils/judgments.dart';

class KartaKzMedical {
  KartaKzMedical({
    required this.uid,
    required this.patient,
    required this.number,
    required this.judgments,
  });

  final String uid;
  final Patient patient;
  final String number;
  final List<MedicaJudgmentInterface> judgments;

  factory KartaKzMedical.fromJson(Map<String, dynamic> json) {
    return KartaKzMedical(
      uid: json['uid'],
      patient: Patient.fromJson(json['patient']),
      number: json['number'],
      judgments: (json['judgments'] as List<dynamic>).map((e) => e['judgmentName'] == medicalMedycynaPracy || e['judgmentName'] == medicalMedycynaPracyInstruktor ? Medicine.fromJson(e) : MedicalJudgment.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};

    json['uid'] = uid;
    json['patient'] = patient.toJson();
    json['number'] = number;
    json['judgments'] = judgments.map((e) => e is Medicine ? e.toJson() : (e as MedicalJudgment).toJson()).toList();

    return json;
  }
}
