import 'package:e_rejestr/models/medical_judgment.dart';
import 'package:e_rejestr/widgets/select_psychology/title.dart';
import 'package:flutter/material.dart';

class Limitation extends StatefulWidget {
  Limitation({required this.medicalJudgment, required this.updateLimit, super.key});

  MedicalJudgment medicalJudgment;
  final Function(String limit, bool value) updateLimit;
  @override
  State<Limitation> createState() => _LimitationState();
}

class _LimitationState extends State<Limitation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleJudgment(name: 'Ograniczenia w zakresie: '),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text('pojazdów, którymi może kierować osoba badana, ich wyposażenia, oznakowania lub przystosowania'),
          value: widget.medicalJudgment.limitA,
          onChanged: (value) {
            widget.updateLimit('A', value!);
          },
        ),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text('specjalnych wymagań wobec osoby kierującej pojazdem'),
          value: widget.medicalJudgment.limitB,
          onChanged: (value) {
            widget.updateLimit('B', value!);
          },
        ),
      ],
    );
  }
}
