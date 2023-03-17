import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextFieldNumber extends StatelessWidget {
  const TextFieldNumber({required this.text, required this.hint, required this.editingController, required this.change, super.key});
  final String text;
  final String hint;
  final TextEditingController editingController;
  final VoidCallback change;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Wrap(
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 20, color: white),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 300,
            child: TextField(
              controller: editingController,
              decoration: const InputDecoration(
                label: Text('1/2/23'),
              ),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () => change(),
            child: const Text('Zmień'),
          ),
        ],
      ),
    );
  }
}
