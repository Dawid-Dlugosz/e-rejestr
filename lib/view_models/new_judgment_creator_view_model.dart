import 'dart:io';

import 'package:e_rejestr/dialogs/open_error.dart';
import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/firm.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/judgment_number.dart';
import 'package:e_rejestr/models/karta_kz.dart';
import 'package:e_rejestr/models/karta_kz_medical.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/models/register.dart';
import 'package:e_rejestr/pdf/karta_kz/karta_kz_page_1.dart';
import 'package:e_rejestr/pdf/karta_kz/karta_kz_page_2.dart';
import 'package:e_rejestr/pdf/medical/page2.dart';
import 'package:e_rejestr/utils/files.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/utils/shared_preferences.dart';
import 'package:e_rejestr/view_models/register_view_model.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:pdf/widgets.dart' as pw;

class NewJudgmentCreatorViewModel extends ChangeNotifier {
  NewJudgmentCreatorViewModel(this.context, {this.register, this.documentType}) {
    _init();
  }
  final BuildContext context;
  final Register? register;
  final DocumentType? documentType;

  bool loaded = false;
  bool showPreviewPopup = false;
  bool enableTextFieldPsycho = false;
  bool enableTextFieldMedic = false;

  TextEditingController psychoTextCotroller = TextEditingController();
  TextEditingController medicalTextController = TextEditingController();

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

  late final RegisterViewModel registerViewModel;
  late String filePath;

  Future<void> _init() async {
    registerViewModel = Provider.of<RegisterViewModel>(context, listen: false);

    if (documentType == DocumentType.medical) {
      await getMedicalKartKzByRegister(register!.getNumberWithOutAlpha());
    }
    if (documentType == DocumentType.psycho) {
      await getPsychoKartKzByRegister(register!.getNumberWithOutAlpha());
    }

    loaded = true;
    notifyListeners();
  }

  Future<void> getPsychoKartKzByRegister(String number) async {
    kartaKzPsycho = await KartaKz.getByNumber(number);
    patient = await Patient.getPatientById(id: kartaKzPsycho!.patientId);
    judgments.addAll(kartaKzPsycho!.judgments);
    notifyListeners();
  }

  Future<void> getMedicalKartKzByRegister(String number) async {
    kartaKzMedical = await KartaKzMedical.getByNumber(number);
    patient = await Patient.getPatientById(id: kartaKzMedical!.patientId);
    if (kartaKzMedical!.firmId != null) {
      firm = await Firm.getFirmById(id: kartaKzMedical!.firmId!);
    }
    judgmentMedicals.addAll(kartaKzMedical!.judgments);
    notifyListeners();
  }

  bool enableChangeKZPsychoNumber() {
    if (enableTextFieldPsycho && psychoTextCotroller.text.isNotEmpty) {
      return false;
    }
    return true;
  }

  bool enableChangeKZMedicalNumber() {
    if (enableTextFieldMedic && medicalTextController.text.isNotEmpty) {
      return false;
    }
    return true;
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
          return getMedicialJudgment(judgment, patient!, firm);
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
          return getPsychoJudgment(judgment, patient!);
        },
      ),
    );

    var file = getFileWithPath(path: path, name: judgment.judgmentName, number: judgment.number);
    await file.writeAsBytes(await pdf.save());
  }

  Future<void> _saveMedicalJudgments() async {
    if (judgmentMedicals.isEmpty) {
      return;
    }
    late String registerNumber;
    if (!enableChangeKZMedicalNumber()) {
      registerNumber = medicalTextController.text;
    } else {
      registerNumber = await registerViewModel.getRegisterMedicalNumber();
    }

    var judgmentNumber = documentType != null ? JudgmentNumber.fromString(kartaKzMedical!.number) : JudgmentNumber.fromString(registerNumber);
    var asciiChar = 65; // A
    if (judgmentMedicals.length > 1) {
      for (var i = 0; i < judgmentMedicals.length; i++) {
        judgmentMedicals[i].number = JudgmentNumber(
          personNo: '${judgmentNumber.personNo}${String.fromCharCode(asciiChar + i)}',
          month: judgmentNumber.month,
          year: judgmentNumber.year,
        ).toString();
      }
    } else {
      judgmentMedicals[0].number = judgmentNumber.toString();
    }

    notifyListeners();
  }

  Future<void> saveFiles() async {
    await _saveMedicalJudgments();
    await _saveJudgments();
    await _createFiles();
  }

  Future<void> _saveJudgments() async {
    if (judgments.isEmpty) {
      return;
    }
    late String registerNumber;
    if (!enableChangeKZPsychoNumber()) {
      registerNumber = psychoTextCotroller.text;
    } else {
      registerNumber = await registerViewModel.getPsychoRegisterNumber();
    }

    var judgmentNumber = documentType != null ? JudgmentNumber.fromString(kartaKzPsycho!.number) : JudgmentNumber.fromString(registerNumber);
    var asciiChar = 65; // A

    if (judgments.length > 1) {
      for (var i = 0; i < judgments.length; i++) {
        judgments[i].number = JudgmentNumber(
          personNo: '${judgmentNumber.personNo}${String.fromCharCode(asciiChar + i)}',
          month: judgmentNumber.month,
          year: judgmentNumber.year,
        ).toString();
        judgments[i].patientName = patient!.getFullName();
        judgments[i].document = patient!.getDocument();
        judgments[i].residence = patient!.residentialAddress.toString();
      }
    } else {
      judgments[0].number = judgmentNumber.toString();
      judgments[0].patientName = patient!.getFullName();
      judgments[0].document = patient!.getDocument();
      judgments[0].residence = patient!.residentialAddress.toString();
    }

    notifyListeners();
  }

  Future<void> _createKzPdf() async {
    var font = await rootBundle.load("fonts/Lato-Regular.ttf");
    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle.load("fonts/Lato-Regular.ttf")),
      bold: pw.Font.ttf(await rootBundle.load("fonts/Lato-Bold.ttf")),
    );

    if (judgments.isNotEmpty) {
      late String nrPsycho;
      if (!enableChangeKZPsychoNumber()) {
        nrPsycho = psychoTextCotroller.text;
      } else {
        nrPsycho = await registerViewModel.getPsychoRegisterNumber();
      }

      var pdf = pw.Document(theme: myTheme);
      pw.Font.ttf(font);

      kartaKzPsycho = KartaKz(
        uid: kartaKzPsycho != null ? kartaKzPsycho!.uid : const Uuid().v4(),
        patientId: patient!.uid,
        number: kartaKzPsycho != null ? kartaKzPsycho!.number : nrPsycho,
        judgments: judgments,
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(10),
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return karta_kz_page_1(patient: patient!, dateOfIssue: judgments[0].dateOfIssue, nrRej: kartaKzPsycho!.number);
          },
        ),
      );
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(10),
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return karta_kz_page_2();
          },
        ),
      );

      var file = getKzFileWithPath(path: filePath, number: kartaKzPsycho!.number, type: DocumentType.psycho);
      await file.writeAsBytes(await pdf.save());
    }

    if (judgmentMedicals.isNotEmpty) {
      late String nrMedical;
      if (!enableChangeKZMedicalNumber()) {
        nrMedical = medicalTextController.text;
      } else {
        nrMedical = await registerViewModel.getRegisterMedicalNumber();
      }
      var pdf = pw.Document(theme: myTheme);
      pw.Font.ttf(font);

      kartaKzMedical = KartaKzMedical(
        uid: kartaKzMedical != null ? kartaKzMedical!.uid : const Uuid().v4(),
        patientId: patient!.uid,
        number: kartaKzMedical != null ? kartaKzMedical!.number : nrMedical,
        judgments: judgmentMedicals,
        firmId: firm != null ? firm!.id : null,
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(10),
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return karta_kz_page_1(patient: patient!, dateOfIssue: judgmentMedicals[0].dateOfIssue, nrRej: kartaKzMedical!.number);
          },
        ),
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(10),
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return karta_kz_page_2();
          },
        ),
      );

      var file = getKzFileWithPath(path: filePath, number: kartaKzMedical!.number, type: DocumentType.medical);
      await file.writeAsBytes(await pdf.save());
    }
    notifyListeners();
  }

  Future<void> addToFirebase() async {
    if (judgments.isNotEmpty) {
      await Firestore.instance.collection(Collection.kartKzPsycho.name).document(kartaKzPsycho!.uid).set(kartaKzPsycho!.toJson());

      if (enableChangeKZPsychoNumber()) {
        var regNumber = JudgmentNumber.fromString(kartaKzPsycho!.number);
        var newRegNumber = '${int.parse(regNumber.personNo) + 1}/${regNumber.month}/${regNumber.year}';
        registerViewModel.updatePsychoRegisterNumber(newRegNumber);
      }
    }

    if (judgmentMedicals.isNotEmpty) {
      await Firestore.instance.collection(Collection.kartKzMedical.name).document(kartaKzMedical!.uid).set(kartaKzMedical!.toJson());

      if (enableChangeKZMedicalNumber()) {
        var regNumber = JudgmentNumber.fromString(kartaKzMedical!.number);
        var newRegNumber = '${int.parse(regNumber.personNo) + 1}/${regNumber.month}/${regNumber.year}';
        registerViewModel.updateMedicalRegisterNumber(newRegNumber);
      }
    }
  }

  Widget printFiles() {
    return PdfPreview(
      padding: const EdgeInsets.symmetric(horizontal: 200),
      canDebug: false,
      canChangePageFormat: false,
      canChangeOrientation: false,
      build: (format) => _generatePdf(format, 'Wszystkie pdf'),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    var font = await rootBundle.load("fonts/Lato-Regular.ttf");
    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle.load("fonts/Lato-Regular.ttf")),
      bold: pw.Font.ttf(await rootBundle.load("fonts/Lato-Bold.ttf")),
    );
    var pdf = pw.Document(theme: myTheme);
    pw.Font.ttf(font);

    if (judgments.isNotEmpty) {
      late String nrPsycho;
      if (!enableChangeKZPsychoNumber()) {
        nrPsycho = psychoTextCotroller.text;
      } else {
        nrPsycho = await registerViewModel.getPsychoRegisterNumber();
      }

      kartaKzPsycho = KartaKz(
        uid: kartaKzPsycho != null ? kartaKzPsycho!.uid : const Uuid().v4(),
        patientId: patient!.uid,
        number: kartaKzPsycho != null ? kartaKzPsycho!.number : nrPsycho,
        judgments: judgments,
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(10),
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return karta_kz_page_1(patient: patient!, dateOfIssue: judgments[0].dateOfIssue, nrRej: kartaKzPsycho!.number);
          },
        ),
      );
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(10),
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return karta_kz_page_2();
          },
        ),
      );

      judgments.forEach((element) {
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return getPsychoJudgment(element, patient!);
            },
          ),
        );
      });
    }

    if (judgmentMedicals.isNotEmpty) {
      late String nrMedical;
      if (!enableChangeKZMedicalNumber()) {
        nrMedical = medicalTextController.text;
      } else {
        nrMedical = await registerViewModel.getRegisterMedicalNumber();
      }

      kartaKzMedical = KartaKzMedical(
        uid: kartaKzMedical != null ? kartaKzMedical!.uid : const Uuid().v4(),
        patientId: patient!.uid,
        number: kartaKzMedical != null ? kartaKzMedical!.number : nrMedical,
        judgments: judgmentMedicals,
        firmId: firm != null ? firm!.id : null,
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(10),
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return karta_kz_page_1(patient: patient!, dateOfIssue: judgmentMedicals[0].dateOfIssue, nrRej: kartaKzMedical!.number);
          },
        ),
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(10),
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return karta_kz_page_2();
          },
        ),
      );

      judgmentMedicals.forEach((element) {
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return getMedicialJudgment(element, patient!, firm);
            },
          ),
        );
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return page2(element.judgmentName);
            },
          ),
        );
      });
    }
    return pdf.save();
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
      await getKzFileWithPath(path: filePath, number: kartaKzMedical!.number, type: DocumentType.medical).delete();
      if (documentType == null) {
        kartaKzMedical = null;
      }
    }

    if (kartaKzPsycho != null) {
      await getKzFileWithPath(path: filePath, number: kartaKzPsycho!.number, type: DocumentType.psycho).delete();
      if (documentType == null) {
        kartaKzPsycho = null;
      }
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

  Future<void> editJudgment() async {
    await saveFiles();
    if (documentType == DocumentType.medical) {
      Firestore.instance.collection(Collection.kartKzMedical.name).document(kartaKzMedical!.uid).update(kartaKzMedical!.toJson());
    }
    if (documentType == DocumentType.psycho) {
      Firestore.instance.collection(Collection.kartKzPsycho.name).document(kartaKzPsycho!.uid).update(kartaKzPsycho!.toJson());
    }

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: printFiles(),
          );
        });
  }
}
