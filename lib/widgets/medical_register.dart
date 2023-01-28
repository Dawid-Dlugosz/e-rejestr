import 'package:e_rejestr/widgets/register_header/register_header.dart';
import 'package:flutter/material.dart';

class MedicalRegister extends StatelessWidget {
  const MedicalRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        RegisterHeader(),
        // TODO STREAM BUILDER Z ORZECZENIAMI Z BAZY DANYCH DLA LEKARSKICH
      ],
    );
  }
}
