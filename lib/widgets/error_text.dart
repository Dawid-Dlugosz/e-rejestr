import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({this.text, super.key});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return text != null
        ? Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              text!,
              style: const TextStyle(
                color: red,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : Container();
  }
}
