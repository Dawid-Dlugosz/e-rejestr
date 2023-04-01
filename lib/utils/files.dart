import 'dart:io';

import 'package:diacritic/diacritic.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/firm.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/medical_judgment.dart';
import 'package:e_rejestr/models/medicine.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_starajacych_sie.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_starajacych_sie_niepelnoletni_3_pieczatki.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_starajacych_sie_przedluzenie.dart';
import 'package:e_rejestr/pdf/medical/kierowcow_uprzywilejowany.dart';
import 'package:e_rejestr/pdf/medical/medycyna_pracy.dart';
import 'package:e_rejestr/pdf/medical/medycyna_pracy_instruktor.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_39.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_alkohol.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_egzamin_instruktor.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_ogolny.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_przedluzenie.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_przywrocenie.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_uprzywilej.dart';
import 'package:e_rejestr/pdf/psychologist/psychologist_wypadek.dart';
import 'package:pdf/widgets.dart' as pw;
import '../pdf/psychologist/psychologist_punkty_karne.dart';
import 'judgments.dart';

File getFileWithPath({required String path, required String name, required String number}) {
  return File('$path\\${removeDiacritics(name.replaceAll(' ', '-'))}-${number.replaceAll('/', '-')}.pdf');
}

File getKzFileWithPath({required String path, required String number, required DocumentType type}) {
  if (type == DocumentType.medical) {
    return File('$path\\karta-kz-medyczna-${number.replaceAll('/', '-')}.pdf');
  }
  return File('$path\\karta-kz-psychologiczna-${number.replaceAll('/', '-')}.pdf');
}

pw.Widget getPsychoJudgment(Judgment judgment, Patient patient) {
  switch (judgment.judgmentName) {
    case judgmentOgolny:
      return psychologist_ogolny(patient: patient, judgment: judgment);
    case judgmentPrzedluzenie:
      return psychologist_przedluzenie(patient: patient, judgment: judgment);
    case judgment39:
      return psychologist_39(patient: patient, judgment: judgment);
    case judgmentUprzywilej:
      return psychologist_uprzywilej(patient: patient, judgment: judgment);
    case judgmentAlkohol:
      return psychologist_alkohol(patient: patient, judgment: judgment);
    case judgmentPunktyKarne:
      return psychologist_punkty_karne(patient: patient, judgment: judgment);
    case judgmentPrzywrocenie:
      return psychologist_przywrocenie(patient: patient, judgment: judgment);
    case judgmentWypadek:
      return psychologist_wypadek(patient: patient, judgment: judgment);
    case judgmentInstruktor:
      return psychologist_egzaminator_instruktor(patient: patient, judgment: judgment);
    default:
      return psychologist_ogolny(patient: patient, judgment: judgment);
  }
}

pw.Widget getMedicialJudgment(MedicaJudgmentInterface judgment, Patient patient, Firm? firm) {
  switch (judgment.judgmentName) {
    case medicalMedycynaPracy:
      return medycyna_pracy(judgment: judgment as Medicine, patient: patient, firm: firm!);
    case medicalMedycynaPracyInstruktor:
      return medycyna_pracy_instruktor(judgment: judgment as Medicine, patient: patient, firm: firm!);
    case medicalStarajacySie:
      return kierowca_starajacy_sie(judgment: judgment as MedicalJudgment, patient: patient);
    case medicalStarajacySiePrzedluzenie:
      return kierowca_starajacy_sie_przedluzenie(judgment: judgment as MedicalJudgment, patient: patient);
    case medicalStarajacySieNieletni:
      return kierowca_starajacy_sie_niepelnoletni_3_pieczatki(judgment: judgment as MedicalJudgment, patient: patient);
    case medicalUprzywilejowany:
      return kierowcow_uprzewilejowanych(judgment: judgment as MedicalJudgment, patient: patient);
    default:
      return medycyna_pracy(judgment: judgment as Medicine, patient: patient, firm: firm!);
  }
}
