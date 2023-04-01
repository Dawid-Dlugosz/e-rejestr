import 'dart:io';

import 'package:e_rejestr/dialogs/open_error.dart';
import 'package:e_rejestr/dialogs/preview_dialog/previed_item.dart';
import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/firm.dart';
import 'package:e_rejestr/models/karta_kz.dart';
import 'package:e_rejestr/models/karta_kz_medical.dart';
import 'package:e_rejestr/models/medical_judgment.dart';
import 'package:e_rejestr/models/medicine.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/models/register.dart';
import 'package:e_rejestr/pdf/karta_kz/karta_kz_page_1.dart';
import 'package:e_rejestr/pdf/karta_kz/karta_kz_page_2.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_starajacych_sie.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_starajacych_sie_niepelnoletni_3_pieczatki.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_starajacych_sie_przedluzenie.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_uprzywilejowany.dart';
import 'package:e_rejestr/pdf/medical/medycyna_pracy.dart';
import 'package:e_rejestr/pdf/medical/medycyna_pracy_instruktor.dart';
import 'package:e_rejestr/pdf/medical/page2.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/files.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/utils/shared_preferences.dart';
import 'package:e_rejestr/widgets/kz_preview.dart';
import 'package:e_rejestr/widgets/loading_widget.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pdf/widgets.dart' as pw;

class MedicalJudgmentPreview extends StatefulWidget {
  const MedicalJudgmentPreview({required this.register, super.key});
  final Register register;
  @override
  State<MedicalJudgmentPreview> createState() => _MedicalJudgmentPreviewState();
}

class _MedicalJudgmentPreviewState extends State<MedicalJudgmentPreview> {
  late String pathFile;
  late KartaKzMedical kartaKzMedical;

  Future<KartaKzMedical> futureKz(String number) async {
    var documents = await Firestore.instance.collection(Collection.kartKzMedical.name).where('number', isEqualTo: number).get();
    var path = await getFilePath();
    var filePath = '$path\\tmp';
    pathFile = filePath;
    if (!await Directory(path).exists()) {
      await Directory(path).create();
    }

    if (!await Directory(filePath).exists()) {
      await Directory(filePath).create();
    }

    var kartKz = KartaKzMedical.fromJson(documents.first.map);
    var patient = await Patient.getPatientById(id: kartKz.patientId);

    Firm? firm;

    if (kartKz.firmId != null) {
      firm = await Firm.getFirmById(id: kartKz.firmId!);
    }

    createFiles(kartKz, filePath, patient, firm);
    return kartKz;
  }

  void openFile(String path) async {
    if (await canLaunchUrl(Uri.file(path))) {
      await launchUrl(Uri.file(path));
    } else {
      showDialog(
        context: context,
        builder: (context) => const OpenError(),
      );
    }
  }

  void createFiles(KartaKzMedical kartaKz, String filePath, Patient patient, Firm? firm) {
    createKzFile(kartaKz, filePath, patient);
    for (var element in kartaKz.judgments) {
      crateMedicalJudgmentPdf(element, filePath, patient, firm);
    }
  }

  Future<void> createKzFile(KartaKzMedical kartaKz, String path, Patient patient) async {
    kartaKzMedical = kartaKz;
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
        margin: const pw.EdgeInsets.all(10),
        orientation: pw.PageOrientation.landscape,
        build: (pw.Context context) {
          return karta_kz_page_1(patient: patient, dateOfIssue: kartaKz.judgments[0].dateOfIssue, nrRej: kartaKz.number);
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

    var file = getKzFileWithPath(path: path, number: kartaKz.number, type: DocumentType.medical);
    await file.writeAsBytes(await pdf.save());
  }

  Future<void> crateMedicalJudgmentPdf(MedicaJudgmentInterface judgment, String path, Patient patient, Firm? firm) async {
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
          return getMedicialJudgment(judgment, patient, firm);
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

  Future<void> deleteFiles() async {
    var path = await getFilePath();
    Directory('$path\\tmp').listSync().forEach((element) {
      if (element is File) {
        element.deleteSync();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: white,
          ),
          onPressed: () async {
            await deleteFiles();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Podgląd orzeczeń',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: white),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<KartaKzMedical>(
                future: futureKz(widget.register.getNumberWithOutAlpha()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null && snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Karta kz',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: white),
                              ),
                              KzPreview(path: pathFile, openFile: openFile, kartaKzMedical: kartaKzMedical),
                              const SizedBox(height: 20),
                              const Text(
                                'Orzeczenia',
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: white),
                              ),
                              Wrap(
                                children: [
                                  ...snapshot.data!.judgments.map(
                                    (e) => FutureBuilder<String>(
                                      future: getFilePath(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData && snapshot.data != null) {
                                          return PreviewItem(
                                            openFile: openFile,
                                            mecicalJudgment: e,
                                            path: '${snapshot.data!}\\tmp',
                                          );
                                        }
                                        return Container();
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                      // return Text(snapshot.data!.number);
                    }
                    return Container();
                  }

                  return const LoadingWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
