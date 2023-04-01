import 'package:e_rejestr/dialogs/delete_kz.dart';
import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/screens/medical_edit.dart';
import 'package:e_rejestr/screens/medical_judgment_preview.dart';
import 'package:e_rejestr/models/register.dart';
import 'package:e_rejestr/screens/psycho_judgment_preview.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/widgets/register_header/header_item.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

class RegisterList extends StatelessWidget {
  const RegisterList({required this.registerItems, required this.documentType, super.key});
  final List<Register> registerItems;
  final DocumentType documentType;

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

  Future<void> deleteKz(String number) async {
    if (documentType == DocumentType.medical) {
      var documents = await Firestore.instance.collection(Collection.kartKzMedical.name).where('number', isEqualTo: number).get();
      var docId = documents.first.map['uid'];
      await Firestore.instance.collection(Collection.kartKzMedical.name).document(docId).delete();
    } else {
      var documents = await Firestore.instance.collection(Collection.kartKzPsycho.name).where('number', isEqualTo: number).get();
      var docId = documents.first.map['uid'];
      await Firestore.instance.collection(Collection.kartKzPsycho.name).document(docId).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Generated code by CHATGTP
    registerItems.sort((a, b) {
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
    });

    return SingleChildScrollView(
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: white, style: BorderStyle.solid, width: 2),
        columnWidths: const {
          0: FractionColumnWidth(0.05),
          1: FractionColumnWidth(0.2),
          2: FractionColumnWidth(0.2),
          3: FractionColumnWidth(0.2),
          4: FractionColumnWidth(0.05),
          5: FractionColumnWidth(0.07),
          6: FractionColumnWidth(0.08),
          7: FractionColumnWidth(0.1),
        },
        children: [
          ...registerItems.map(
            (e) => TableRow(
              children: [
                HeaderItem(e.lp),
                HeaderItem(e.getNameAndAddress()),
                HeaderItem(e.documentNumber),
                HeaderItem(e.getFormatedArticels()),
                const HeaderItem(''),
                HeaderItem(e.releaseDate),
                const HeaderItem(''),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // TODO ZROBIĆ TO GDZIE JEST TWORZENIE TYCH ORZECZEŃ, BĘDZIE TAK NAPROŚCIEJ
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MedicalEdit(
                                        register: e,
                                      )));
                        },
                        child: const Text('Edytuj'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (documentType == DocumentType.medical) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MedicalJudgmentPreview(register: e),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PsychoJudgmentPreview(register: e),
                              ),
                            );
                          }
                          // TODO ZROBIĆ ODZIELNE ŻECZY DLA REJESTRU PSYCHOLOGICZNEGO
                        },
                        child: const Text('Podgląd'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                child: DeleteKz(number: e.getNumberWithOutAlpha()),
                              );
                            },
                          ).then((value) async {
                            if (value != null && value == true) {
                              await deleteKz(e.getNumberWithOutAlpha());
                            }
                          });
                        },
                        child: const Text('Usuń'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
