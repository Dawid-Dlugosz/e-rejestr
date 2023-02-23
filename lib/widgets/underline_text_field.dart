import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnderLineTextField extends StatelessWidget {
  const UnderLineTextField({required this.title, required this.controller, this.mask, this.hint, this.inputType, super.key});
  final String title;
  final TextEditingController controller;
  final TextInputFormatter? mask;
  final String? hint;
  final TextInputType? inputType;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: white, width: 3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title)),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: inputType,
              decoration: simpleInputDecoration(hint: hint),
              inputFormatters: mask != null ? [mask!] : null,
            ),
          )
        ],
      ),
    );
  }
}
