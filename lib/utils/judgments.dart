import 'package:e_rejestr/models/register.dart';

const judgmentOgolny = 'Ogólny';
const judgmentPrzedluzenie = 'Przedłużenie';
const judgment39 = '39';
const judgmentUprzywilej = 'Uprzywilej';
const judgmentAlkohol = 'Alkohol';
const judgmentPunktyKarne = 'Punkty karne';
const judgmentPrzywrocenie = 'Przywrócenie';
const judgmentWypadek = 'Wypadek';
const judgmentInstruktor = 'Instruktor';
const medicalMedycynaPracy = 'Medycyna pracy';
const medicalMedycynaPracyInstruktor = 'Medycyna pracy instruktor';
const medicalStarajacySie = 'Kierowca starający się';
const medicalStarajacySiePrzedluzenie = 'Kierowca starający się przedłużenie';
const medicalStarajacySieNieletni = 'Kierowca starający się przedłużenie nieletni 3 pieczątki';
const medicalUprzywilejowany = 'Kirowcy poj. uprzywilejowanych lub przewożące pieniądze';

const art82 = 'art. 82';
const art39 = 'art. 39k';
const artMedicine = 'art. 43 art. 229';
const art75 = 'art. 75';

String getJudgmentArticle(String name) {
  switch (name) {
    case judgmentOgolny:
      return art82;
    case judgmentPrzywrocenie:
      return art82;
    case judgment39:
      return art39;
    case judgmentUprzywilej:
      return art82;
    case judgmentAlkohol:
      return art82;
    case judgmentPunktyKarne:
      return art82;
    case judgmentPrzedluzenie:
      return art82;
    case judgmentWypadek:
      return art82;
    case judgmentInstruktor:
      return art82;
    case medicalMedycynaPracy:
      return artMedicine;
    case medicalMedycynaPracyInstruktor:
      return artMedicine;
    case medicalStarajacySiePrzedluzenie:
      return art75;
    case medicalStarajacySieNieletni:
      return art75;
    case medicalStarajacySie:
      return art75;
    case medicalUprzywilejowany:
      return art75;
    default:
      return '';
  }
}

int sortRegister(Register a, Register b) {
  List<String> aParts = a.lp.split('/');
  List<String> bParts = b.lp.split('/');

  String aOrder = aParts[0];
  String bOrder = bParts[0];

  int aMonth = int.parse(aParts[1]);
  int bMonth = int.parse(bParts[1]);

  int aYear = int.parse(aParts[2]);
  int bYear = int.parse(bParts[2]);

  // Compare the components in ascending order: year, month, order
  if (aYear != null && bYear != null && aYear != bYear) {
    return aYear.compareTo(bYear);
  } else if (aMonth != null && bMonth != null && aMonth != bMonth) {
    return aMonth.compareTo(bMonth);
  } else {
    List<String> aOrderSubcomponents = splitOrderSubcomponents(aOrder);
    List<String> bOrderSubcomponents = splitOrderSubcomponents(bOrder);

    for (int i = 0; i < aOrderSubcomponents.length && i < bOrderSubcomponents.length; i++) {
      bool aIsNumeric = int.tryParse(aOrderSubcomponents[i]) != null;
      bool bIsNumeric = int.tryParse(bOrderSubcomponents[i]) != null;

      if (aIsNumeric && bIsNumeric) {
        int aNumber = int.parse(aOrderSubcomponents[i]);
        int bNumber = int.parse(bOrderSubcomponents[i]);

        if (aNumber != bNumber) {
          return aNumber.compareTo(bNumber);
        }
      } else if (aIsNumeric && !bIsNumeric) {
        return -1;
      } else if (!aIsNumeric && bIsNumeric) {
        return 1;
      } else {
        int cmp = aOrderSubcomponents[i].compareTo(bOrderSubcomponents[i]);

        if (cmp != 0) {
          return cmp;
        }
      }
    }

    // If we've compared all subcomponents and they're still equal, compare the lengths of the subcomponents
    return aOrderSubcomponents.length.compareTo(bOrderSubcomponents.length);
  }
}

List<String> splitOrderSubcomponents(String order) {
  List<String> subcomponents = [];

  String currentSubcomponent = '';
  bool lastIsNumeric = false;

  for (int i = 0; i < order.length; i++) {
    bool isNumeric = int.tryParse(order[i]) != null;

    if (isNumeric == lastIsNumeric) {
      currentSubcomponent += order[i];
    } else {
      subcomponents.add(currentSubcomponent);
      currentSubcomponent = order[i];
      lastIsNumeric = isNumeric;
    }
  }

  subcomponents.add(currentSubcomponent);

  return subcomponents;
}
