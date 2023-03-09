import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/widgets/select_psychology/title.dart';
import 'package:flutter/material.dart';

class CarsCategory extends StatefulWidget {
  CarsCategory({
    required this.judgmentName,
    required this.carA,
    required this.carB,
    required this.carC,
    required this.updateCar,
    super.key,
  });

  bool carA;
  bool carB;
  bool carC;
  final String judgmentName;
  final Function(String car, bool value) updateCar;

  @override
  State<CarsCategory> createState() => _CarsCategoryState();
}

String carA(String value) {
  switch (value) {
    case judgmentUprzywilej:
      return 'A1, A2, A';
    case judgmentInstruktor:
      return 'instruktora';
    default:
      return 'AM, A1, A2, A, B1, B, B+E, T,';
  }
}

String carB(String value) {
  switch (value) {
    case judgmentUprzywilej:
      return 'B1, B, B+E';
    case judgmentInstruktor:
      return 'egzaminatora';
    default:
      return 'C1, C1+E, C, C+E, D1, D1+E, D, D+E';
  }
}

String carC(String value) {
  switch (value) {
    case judgmentUprzywilej:
      return 'C1+E, C, C+E, D1, D1+E, D, D+E **)';
    case judgmentInstruktor:
      return 'instruktora technik jazdy';
    default:
      return 'tramwajem';
  }
}

class _CarsCategoryState extends State<CarsCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleJudgment(name: 'Kierowane pojazdy: '),
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
      ],
    );
  }
}
