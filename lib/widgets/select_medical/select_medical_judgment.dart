import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';

class SelectMedicalJudgment extends StatelessWidget {
  SelectMedicalJudgment({required this.name, required this.addRemoveJudgment, required this.updateJudgment, required this.select, super.key});
  final String name;
  final Function(MedicaJudgmentInterface judgment) addRemoveJudgment;
  final Function(MedicaJudgmentInterface judgment) updateJudgment;
  bool select;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: white, width: 3),
      ),
      child: Column(
        children: [
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              name,
              style: const TextStyle(fontSize: 23),
            ),
            value: select,
            onChanged: (value) {
              // setState(() {
              //   widget.addRemoveJudgment(judgment);
              //   widget.select = value!;
              //   if (widget.select) {
              //     _controller.forward();
              //   } else {
              //     _controller.reverse();
              //   }
              // });
            },
          ),
        ],
      ),
    );
  }
}
