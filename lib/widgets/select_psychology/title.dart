import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TitleJudgment extends StatelessWidget {
  const TitleJudgment({required this.name, super.key});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        name,
        style: const TextStyle(color: white, fontSize: 20),
        textAlign: TextAlign.left,
      ),
    );
  }
}
