import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/register.dart';
import 'package:e_rejestr/screens/register_list.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/widgets/empty_widget.dart';
import 'package:e_rejestr/widgets/loading_widget.dart';
import 'package:e_rejestr/widgets/register_header/register_header.dart';
import 'package:e_rejestr/widgets/register_menu.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';

class PsychologicalRegister extends StatefulWidget {
  const PsychologicalRegister({super.key});

  @override
  State<PsychologicalRegister> createState() => _PsychologicalRegisterState();
}

class _PsychologicalRegisterState extends State<PsychologicalRegister> {
  Future<List<Register>> convertToList(List<Document> documents) async {
    var registers = <Register>[];

    for (var element in documents) {
      var listOfJudgment = (element.map['judgments'] as List<dynamic>)
          .map((e) => Judgment.fromJson(e))
          .toList();
      var articles = listOfJudgment.map((e) => e.article).toList();
      for (var judgment in listOfJudgment) {
        var json = await Register.convertPsychologicalJudgmentToRegister(
            patientId: element.map['patientId'],
            judgment: judgment,
            articles: articles);
        var register = Register.fromJson(json);

        if (register.fullName
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          registers.add(register);
        }
      }
    }

    return registers;
  }

  TextEditingController searchController = TextEditingController();
  var stream =
      Firestore.instance.collection(Collection.kartKzPsycho.name).stream;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RegisterMenu(
          onTextChange: (String text) {
            setState(() {
              searchController.text = text;
            });
          },
        ),
        const RegisterHeader(),
        const SizedBox(height: 10),
        Expanded(
          child: StreamBuilder<List<Document>>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.active) {
                return const LoadingWidget();
              }
              if (snapshot.hasData && snapshot.data != null) {
                return FutureBuilder<List<Register>>(
                    future: convertToList(snapshot.data!),
                    builder: (context, futureSnap) {
                      if (futureSnap.hasData && snapshot.data != null) {
                        if (snapshot.data!.isEmpty ||
                            futureSnap.data!.isEmpty) {
                          return const EmptyWidget();
                        }

                        return RegisterList(
                          registerItems: futureSnap.data!,
                          documentType: DocumentType.psycho,
                        );
                      }

                      return Container();
                    });
              }
              return const Text(
                'Wystąpił niespodziwany błąd',
                style: TextStyle(color: red, fontSize: 30),
              );
            },
          ),
        ),
      ],
    );
  }
}
