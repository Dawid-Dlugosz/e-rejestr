import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';

class PatientHeaderItem extends StatelessWidget {
  PatientHeaderItem(this.title, {this.height, super.key});

  final String title;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: const TextStyle(color: white, fontSize: 30),
      ),
    );
  }
}
