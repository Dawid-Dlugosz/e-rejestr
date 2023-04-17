import 'package:e_rejestr/dialogs/delete_kz.dart';
import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/screens/medical_edit.dart';
import 'package:e_rejestr/screens/medical_judgment_preview.dart';
import 'package:e_rejestr/models/register.dart';
import 'package:e_rejestr/screens/new_judgment.dart';
import 'package:e_rejestr/screens/psycho_judgment_preview.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/widgets/register_header/header_item.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/new_judgment_creator_view_model.dart';

class RegisterList extends StatelessWidget {
  const RegisterList({required this.registerItems, required this.documentType, super.key});
  final List<Register> registerItems;
  final DocumentType documentType;

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
    registerItems.sort((a, b) => sortRegister(a, b));

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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (_) => NewJudgmentCreatorViewModel(context, register: e, documentType: documentType),
                                child: const NewJudgmentCreator(),
                              ),
                            ),
                          );
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
