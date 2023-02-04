import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PatientHeaderItem extends StatelessWidget {
  const PatientHeaderItem(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: white, width: 2),
        ),
        child: Text(
          title,
          style: const TextStyle(color: white, fontSize: 30),
        ),
      ),
    );
  }
}
