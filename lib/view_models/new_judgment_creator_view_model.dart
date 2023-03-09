import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/firm.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/judgment_number.dart';
import 'package:e_rejestr/models/karta_kz.dart';
import 'package:e_rejestr/models/medical_judgment.dart';
import 'package:e_rejestr/models/medicine.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/view_models/medical_register_view_model.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NewJudgmentCreatorViewModel extends ChangeNotifier {
  NewJudgmentCreatorViewModel(this.context) {
    _init();
  }
  final BuildContext context;

  bool loaded = false;

  List<String> typeOfJudgments = [
    judgmentOgolny,
    judgmentPrzedluzenie,
    judgment39,
    judgmentUprzywilej,
    judgmentAlkohol,
    judgmentPunktyKarne,
    judgmentPrzywrocenie,
    judgmentWypadek,
    judgmentInstruktor,
  ];

  List<String> typeOfJudgmentsMedical = [
    medicalMedycynaPracy,
    medicalMedycynaPracyInstruktor,
    medicalStarajacySie,
    medicalStarajacySiePrzedluzenie,
    medicalStarajacySieNieletni,
  ];

  List<Judgment> judgments = [];
  List<MedicaJudgmentInterface> judgmentMedicals = [];

  Firm? firm;

  late final MedicalRegisterViewModel medicalRegisterViewModel;
  Future<void> _init() async {
    // TODO zrobić sprawdzanie czy zmenił się miesiąc jeśli tak wyzeorwać licznik i ustawić na 1 i miesiać + 1
    medicalRegisterViewModel = Provider.of<MedicalRegisterViewModel>(context, listen: false);
    loaded = true;
    notifyListeners();
  }

  void addRemoveMedicalJudgment(MedicaJudgmentInterface judgment) {
    if (judgmentMedicals.where((element) => element.judgmentName == judgment.judgmentName).isEmpty) {
      judgmentMedicals.add(judgment);
    } else {
      judgmentMedicals.removeWhere((element) => element.judgmentName == judgment.judgmentName);
    }
    notifyListeners();
  }

  void updateMedicalJudgment(MedicaJudgmentInterface judgment) {
    judgmentMedicals[judgmentMedicals.indexWhere((element) => element.judgmentName == judgment.judgmentName)] = judgment;
    notifyListeners();
  }

  void addRemoveJudgment(Judgment judgment) {
    if (judgments.where((element) => element.judgmentName == judgment.judgmentName).isEmpty) {
      judgments.add(judgment);
    } else {
      judgments.removeWhere((element) => element.judgmentName == judgment.judgmentName);
    }
    notifyListeners();
  }

  void updateJudgment(Judgment judgment) {
    judgments[judgments.indexWhere((element) => element.judgmentName == judgment.judgmentName)] = judgment;
    notifyListeners();
  }

  Future<void> saveMedicalJudgments(Patient patient) async {
    //TODO ZROBIĆ ZAPIS MEDYCZNEGO ORZECZENIE

    // createMedicalKartKz();
  }

  Future<void> createMedicalKartKz(Patient patient, String number) async {
    //TODO ZROBIĆ ZAPIS KARTY KZ DLA ORZECZENIA MEDYCZNEGO
  }

  void _addFirmToMedicineJudgment() {
    if (firm == null) {
      return;
    }

    judgmentMedicals.forEach((element) {
      if (element.judgmentName == medicalMedycynaPracyInstruktor || element.judgmentName == medicalMedycynaPracy) {
        (element as Medicine).firm = firm!;
      }
    });
  }

  void _createFiles() {}

  Future<void> saveJudgments(Patient patient) async {
    var registerNumber = await medicalRegisterViewModel.getPsychoRegisterNumber();
    var judgmentNumber = JudgmentNumber.fromString(registerNumber);
    var asciiChar = 65; // A

    if (judgments.length > 1) {
      for (var i = 0; i < judgments.length; i++) {
        judgments[i].number = JudgmentNumber(
          personNo: '${judgmentNumber.personNo}${String.fromCharCode(asciiChar + i)}',
          month: judgmentNumber.month,
          year: judgmentNumber.year,
        ).toString();
        judgments[i].patientName = patient.getFullName();
        judgments[i].document = patient.getDocument();
        judgments[i].residence = patient.residentialAddress.toString();
      }
    } else {
      judgments[0].number = judgmentNumber.toString();
      judgments[0].patientName = patient.getFullName();
      judgments[0].document = patient.getDocument();
      judgments[0].residence = patient.residentialAddress.toString();
    }
    notifyListeners();

    await createKartKz(patient, judgmentNumber.toString());
  }

  Future<void> createKartKz(Patient patient, String number) async {
    var kartaKz = KartaKz(
      uid: const Uuid().v4(),
      patient: patient,
      number: number,
      judgments: judgments,
    );

    await Firestore.instance.collection(Collection.kartaKzPsycho.name).document(kartaKz.uid).create(kartaKz.toJson());
  }
}
