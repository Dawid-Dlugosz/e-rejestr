import 'dart:io';

import 'package:e_rejestr/dialogs/open_error.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/firm.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/judgment_number.dart';
import 'package:e_rejestr/models/karta_kz.dart';
import 'package:e_rejestr/models/karta_kz_medical.dart';
import 'package:e_rejestr/models/medical_judgment.dart';
import 'package:e_rejestr/models/medicine.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/pdf/karta_kz/karta_kz_page_1.dart';
import 'package:e_rejestr/pdf/karta_kz/karta_kz_page_2.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_starajacych_sie.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_starajacych_sie_niepelnoletni_3_pieczatki.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_starajacych_sie_przedluzenie.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_uprzywilejowany.dart';
import 'package:e_rejestr/pdf/medical/medycyna_pracy.dart';
import 'package:e_rejestr/pdf/medical/medycyna_pracy_instruktor.dart';
import 'package:e_rejestr/pdf/medical/page2.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_39.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_alkohol.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_egzamin_instruktor.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_ogolny.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_przedluzenie.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_przywrocenie.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_punkty_karne.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_uprzywilej.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_wypadek.dart';
import 'package:e_rejestr/utils/files.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/utils/shared_preferences.dart';
import 'package:e_rejestr/view_models/medical_register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:pdf/widgets.dart' as pw;

class NewJudgmentCreatorViewModel extends ChangeNotifier {
  NewJudgmentCreatorViewModel(this.context) {
    _init();
  }
  final BuildContext context;

  bool loaded = false;
  bool showPreviewPopup = false;
  bool loadPreview = false;

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
  Patient? patient;
  KartaKz? kartaKzPsycho;
  KartaKzMedical? kartaKzMedical;

  late final MedicalRegisterViewModel medicalRegisterViewModel;
  late String filePath;

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

  Future<void> createMedicalKartKz(Patient patient, String number) async {
    //TODO ZROBIĆ ZAPIS KARTY KZ DLA ORZECZENIA MEDYCZNEGO
  }

  void _addFirmToMedicineJudgment() {
    if (firm == null) {
      return;
    }

    for (var element in judgmentMedicals) {
      if (element.judgmentName == medicalMedycynaPracyInstruktor || element.judgmentName == medicalMedycynaPracy) {
        (element as Medicine).firm = firm!;
      }
    }
  }

  Future<void> _createFiles() async {
    var path = await getFilePath();
    var montFolder = '${DateTime.now().month}-${DateTime.now().year}';
    filePath = '$path\\$montFolder';

    notifyListeners();
    if (!await Directory(filePath).exists()) {
      await Directory(filePath).create();
    }

    if (judgments.isNotEmpty) {
      for (var element in judgments) {
        _createPsychoJudgmentPdf(element, filePath);
      }
    }

    if (judgmentMedicals.isNotEmpty) {
      for (var element in judgmentMedicals) {
        _crateMedicalJudgmentPdf(element, filePath);
      }
    }

    await _createKzPdf();
  }

  Future<void> _crateMedicalJudgmentPdf(MedicaJudgmentInterface judgment, String path) async {
    var font = await rootBundle.load("fonts/Lato-Regular.ttf");
    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle.load("fonts/Lato-Regular.ttf")),
      bold: pw.Font.ttf(await rootBundle.load("fonts/Lato-Bold.ttf")),
    );

    var pdf = pw.Document(theme: myTheme);
    pw.Font.ttf(font);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return _getMedicialJudgment(judgment);
        },
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return page2(judgment.judgmentName);
        },
      ),
    );

    var file = getFileWithPath(path: path, name: judgment.judgmentName, number: judgment.number);
    await file.writeAsBytes(await pdf.save());
  }

  Future<void> _createPsychoJudgmentPdf(Judgment judgment, String path) async {
    var font = await rootBundle.load("fonts/Lato-Regular.ttf");
    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle.load("fonts/Lato-Regular.ttf")),
      bold: pw.Font.ttf(await rootBundle.load("fonts/Lato-Bold.ttf")),
    );

    var pdf = pw.Document(theme: myTheme);
    pw.Font.ttf(font);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return _getPsychoJudgment(judgment);
        },
      ),
    );

    var file = getFileWithPath(path: path, name: judgment.judgmentName, number: judgment.number);
    await file.writeAsBytes(await pdf.save());
  }

  pw.Widget _getMedicialJudgment(MedicaJudgmentInterface judgment) {
    switch (judgment.judgmentName) {
      case medicalMedycynaPracy:
        return medycyna_pracy(judgment: judgment as Medicine);
      case medicalMedycynaPracyInstruktor:
        return medycyna_pracy_instruktor(judgment: judgment as Medicine);
      case medicalStarajacySie:
        return kierowca_starajacy_sie(judgment: judgment as MedicalJudgment);
      case medicalStarajacySiePrzedluzenie:
        return kierowca_starajacy_sie_przedluzenie(judgment: judgment as MedicalJudgment);
      case medicalStarajacySieNieletni:
        return kierowca_starajacy_sie_niepelnoletni_3_pieczatki(judgment: judgment as MedicalJudgment);
      case medicalUprzywilejowany:
        return kierowcow_uprzewilejowanych(judgment: judgment as MedicalJudgment);
      default:
        return medycyna_pracy(judgment: judgment as Medicine);
    }
  }

  pw.Widget _getPsychoJudgment(Judgment judgment) {
    switch (judgment.judgmentName) {
      case judgmentOgolny:
        return psychologist_ogolny(patient: patient!, judgment: judgment);
      case judgmentPrzedluzenie:
        return psychologist_przedluzenie(patient: patient!, judgment: judgment);
      case judgment39:
        return psychologist_39(patient: patient!, judgment: judgment);
      case judgmentUprzywilej:
        return psychologist_uprzywilej(patient: patient!, judgment: judgment);
      case judgmentAlkohol:
        return psychologist_alkohol(patient: patient!, judgment: judgment);
      case judgmentPunktyKarne:
        return psychologist_punkty_karne(patient: patient!, judgment: judgment);
      case judgmentPrzywrocenie:
        return psychologist_przywrocenie(patient: patient!, judgment: judgment);
      case judgmentWypadek:
        return psychologist_wypadek(patient: patient!, judgment: judgment);
      case judgmentInstruktor:
        return psychologist_egzaminator_instruktor(patient: patient!, judgment: judgment);
      default:
        return psychologist_ogolny(patient: patient!, judgment: judgment);
    }
  }

  Future<void> saveMedicalJudgments(Patient patient, {bool saveAndPrint = false}) async {
    if (judgmentMedicals.isEmpty) {
      return;
    }

    var registerNumber = await medicalRegisterViewModel.getRegisterNumbre();
    var judgmentNumber = JudgmentNumber.fromString(registerNumber);
    var asciiChar = 65; // A
    if (judgmentMedicals.length > 1) {
      for (var i = 0; i < judgmentMedicals.length; i++) {
        judgmentMedicals[i].number = JudgmentNumber(
          personNo: '${judgmentNumber.personNo}${String.fromCharCode(asciiChar + i)}',
          month: judgmentNumber.month,
          year: judgmentNumber.year,
        ).toString();
        judgmentMedicals[i].patient = patient;
      }
    } else {
      judgmentMedicals[0].number = judgmentNumber.toString();
      judgmentMedicals[0].patient = patient;
    }
    _addFirmToMedicineJudgment();

    _createFiles();

    notifyListeners();
  }

  Future<void> saveJudgments(Patient patient, {bool saveAndPrint = false}) async {
    if (judgments.isEmpty) {
      return;
    }

    this.patient = patient;
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

    _createFiles();

    // TODO ZROBIĆ SAVE dodaćdo firebase I ODRAZU DO DRUKU
    notifyListeners();
  }

  Future<void> _createKzPdf() async {
    var font = await rootBundle.load("fonts/Lato-Regular.ttf");
    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle.load("fonts/Lato-Regular.ttf")),
      bold: pw.Font.ttf(await rootBundle.load("fonts/Lato-Bold.ttf")),
    );

    var pdf = pw.Document(theme: myTheme);
    pw.Font.ttf(font);

    if (judgments.isNotEmpty) {
      var nrPsycho = await medicalRegisterViewModel.getPsychoRegisterNumber();

      kartaKzPsycho = KartaKz(
        uid: const Uuid().v4(),
        patient: patient!,
        number: nrPsycho,
        judgments: judgments,
      );

      // TODO ZROBIĆ ODWÓCONĄ KARTĘ I CZEMU NIE ZAPISUJE SIĘ MEDYCZNA
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return karta_kz_page_1(patient: patient!, dateOfIssue: judgments[0].dateOfIssue, nrRej: nrPsycho);
          },
        ),
      );
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return karta_kz_page_2();
          },
        ),
      );

      var file = getKzFileWithPath(path: filePath, number: nrPsycho, type: Documents.psycho);
      await file.writeAsBytes(await pdf.save());
    }

    if (judgmentMedicals.isNotEmpty) {
      var nrMedical = await medicalRegisterViewModel.getRegisterNumbre();

      kartaKzMedical = KartaKzMedical(
        uid: const Uuid().v4(),
        patient: patient!,
        number: nrMedical,
        judgments: judgmentMedicals,
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return karta_kz_page_1(patient: patient!, dateOfIssue: judgments[0].dateOfIssue, nrRej: nrMedical);
          },
        ),
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return karta_kz_page_2();
          },
        ),
      );

      var file = getKzFileWithPath(path: filePath, number: nrMedical, type: Documents.medical);
      await file.writeAsBytes(await pdf.save());
    }
    notifyListeners();
  }

  Future<void> addToFirebase() async {
    if (judgments.isNotEmpty) {
      var number = await medicalRegisterViewModel.getPsychoRegisterNumber();
      _saveKzPsycho(number);
      // TODO ZROBIĆ UPDATE NUMERU
    }

    if (judgmentMedicals.isNotEmpty) {
      var number = await medicalRegisterViewModel.getRegisterNumbre();
      _saveKzMedicial(number);
      // TODO ZROBIĆ UPDATE NUMERU
    }
  }

  Future<void> _saveKzMedicial(String number) async {
    var kartaKz = KartaKzMedical(
      uid: const Uuid().v4(),
      patient: patient!,
      number: number,
      judgments: judgmentMedicals,
    );

    // await Firestore.instance.collection(Collection.kartaKzMedical.name).document(kartaKz.uid).create(kartaKz.toJson());
  }

  Future<void> _saveKzPsycho(String number) async {
    var kartaKz = KartaKz(
      uid: const Uuid().v4(),
      patient: patient!,
      number: number,
      judgments: judgments,
    );

    // await Firestore.instance.collection(Collection.kartaKzPsycho.name).document(kartaKz.uid).create(kartaKz.toJson());
  }

  Future<void> openFile(String path) async {
    if (await canLaunchUrl(Uri.file(path))) {
      await launchUrl(Uri.file(path));
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => const OpenError(),
      );
    }
  }

  Future<void> removeFiles() async {
    if (kartaKzMedical != null) {
      await getKzFileWithPath(path: filePath, number: kartaKzMedical!.number, type: Documents.medical).delete();
      kartaKzMedical = null;
    }

    if (kartaKzPsycho != null) {
      await getKzFileWithPath(path: filePath, number: kartaKzMedical!.number, type: Documents.psycho).delete();
      kartaKzPsycho = null;
    }

    if (judgments.isNotEmpty) {
      for (var element in judgments) {
        await getFileWithPath(path: filePath, name: element.judgmentName, number: element.number).delete();
      }
    }

    if (judgmentMedicals.isNotEmpty) {
      for (var element in judgmentMedicals) {
        await getFileWithPath(path: filePath, name: element.judgmentName, number: element.number).delete();
      }
    }

    notifyListeners();
  }
}
