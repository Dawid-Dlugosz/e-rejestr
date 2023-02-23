import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/widgets/select_psychology/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

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

class _CarsCategoryState extends State<CarsCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleJudgment(name: 'Kierowane pojazdy: '),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(widget.judgmentName == judgmentUprzywilej ? 'A1, A2, A' : 'AM, A1, A2, A, B1, B, B+E, T,'),
          value: widget.carA,
          onChanged: (value) {
            widget.updateCar('A', value!);
          },
        ),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(widget.judgmentName == judgmentUprzywilej ? 'B1, B, B+E' : 'C1, C1+E, C, C+E, D1, D1+E, D, D+E'),
          value: widget.carB,
          onChanged: (value) {
            widget.updateCar('B', value!);
          },
        ),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(widget.judgmentName == judgmentUprzywilej ? 'C1+E, C, C+E, D1, D1+E, D, D+E **)' : 'tramwajem'),
          value: widget.carC,
          onChanged: (value) {
            widget.updateCar('C', value!);
          },
        ),
      ],
    );
  }
}
