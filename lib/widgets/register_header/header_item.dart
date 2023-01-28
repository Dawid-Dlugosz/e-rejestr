import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';

class HeaderItem extends StatelessWidget {
  const HeaderItem(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18.0,
          color: white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
