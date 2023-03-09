import 'package:flutter/material.dart';

import '../select_psychology/title.dart';

class TypMedical extends StatefulWidget {
  TypMedical({required this.typeMedical, required this.updateType, super.key});

  String typeMedical;
  final Function(String value) updateType;

  @override
  State<TypMedical> createState() => _TypMedicalState();
}

class _TypMedicalState extends State<TypMedical> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleJudgment(name: 'Typ badań: '),
        RadioListTile(
          title: const Text('Wstępne'),
          value: 'Wstępne',
          groupValue: widget.typeMedical,
          onChanged: (value) {
            widget.updateType(value!);
          },
        ),
        RadioListTile(
          title: const Text('Okresowe'),
          value: 'Okresowe',
          groupValue: widget.typeMedical,
          onChanged: (value) {
            widget.updateType(value!);
          },
        ),
        RadioListTile(
          title: const Text('Kontrolne'),
          value: 'Kontrolne',
          groupValue: widget.typeMedical,
          onChanged: (value) {
            widget.updateType(value!);
          },
        ),
      ],
    );
  }
}
