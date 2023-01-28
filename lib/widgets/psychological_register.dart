import 'package:e_rejestr/widgets/register_header/register_header.dart';
import 'package:flutter/material.dart';

class PsychologicalRegister extends StatelessWidget {
  const PsychologicalRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        RegisterHeader(),
        // TODO STREAM BUILDER Z ORZECZENIAMI Z BAZY DANYCH DLA PSZYCHOLOGICZNYCH
      ],
    );
  }
}
