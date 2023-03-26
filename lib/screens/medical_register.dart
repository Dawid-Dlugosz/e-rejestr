import 'package:e_rejestr/enums/collections.dart';
import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/models/register.dart';
import 'package:e_rejestr/screens/register_list.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/widgets/empty_widget.dart';
import 'package:e_rejestr/widgets/loading_widget.dart';
import 'package:e_rejestr/widgets/register_header/register_header.dart';
import 'package:e_rejestr/widgets/register_menu.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';

class MedicalRegister extends StatefulWidget {
  const MedicalRegister({super.key});

  @override
  State<MedicalRegister> createState() => _MedicalRegisterState();
}

class _MedicalRegisterState extends State<MedicalRegister> {
  Future<List<Register>> convertToList(List<Document> documents) async {
    var registers = <Register>[];

    for (var element in documents) {
      var json = await Register.converJugmnetToRightPdf(element.map, DocumentType.medical);
      var register = Register.fromJson(json);
      if (register.fullName.contains(searchController.text)) {
        registers.add(register);
      }
    }

    return registers;
  }

  TextEditingController searchController = TextEditingController();
  var stream = Firestore.instance.collection(Collection.kartKzMedical.name).stream;

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
                        if (snapshot.data!.isEmpty || futureSnap.data!.isEmpty) {
                          return const EmptyWidget();
                        }

                        return RegisterList(registerItems: futureSnap.data!);
                        // TODO ZROBIĆ CRUDA REJESTRU
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