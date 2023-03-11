import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/widgets/select_psychology/title.dart';
import 'package:flutter/material.dart';

class CarsCategoryMedicial extends StatefulWidget {
  CarsCategoryMedicial({
    required this.judgmentName,
    required this.carA,
    required this.carB,
    required this.carC,
    required this.carD,
    required this.updateCar,
    super.key,
  });

  bool carA;
  bool carB;
  bool carC;
  bool carD;
  final String judgmentName;
  final Function(String car, bool value) updateCar;

  @override
  State<CarsCategoryMedicial> createState() => _CarsCategoryMedicialState();
}

String carA(String value) {
  switch (value) {
    case medicalUprzywilejowany:
      return 'A1, A2, A;';
    default:
      return 'AM, A1, A2, A, B1, B, B+E, T,';
  }
}

String carB(String value) {
  switch (value) {
    case medicalUprzywilejowany:
      return 'B1, B, B+E;';
    default:
      return 'C1, C1+E, C, C+E, D1, D1+E, D, D+E,';
  }
}

String carC(String value) {
  switch (value) {
    case medicalUprzywilejowany:
      return 'C1, C1+E, C, C+E;';
    default:
      return 'C1, C1+E, C, C+E;';
  }
}

String carD(String value) {
  switch (value) {
    case medicalUprzywilejowany:
      return 'D1, D1+E, D, D+E';
    default:
      return 'pozwolenie na kierowanie tramwajem';
  }
}

class _CarsCategoryMedicialState extends State<CarsCategoryMedicial> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleJudgment(name: 'Prawo jazdy kategorii'),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(carA(widget.judgmentName)),
          value: widget.carA,
          onChanged: (value) {
            widget.updateCar('A', value!);
          },
        ),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(carB(widget.judgmentName)),
          value: widget.carB,
          onChanged: (value) {
            widget.updateCar('B', value!);
          },
        ),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(carC(widget.judgmentName)),
          value: widget.carC,
          onChanged: (value) {
            widget.updateCar('C', value!);
          },
        ),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(carD(widget.judgmentName)),
          value: widget.carD,
          onChanged: (value) {
            widget.updateCar('D', value!);
          },
        ),
      ],
    );
  }
}
