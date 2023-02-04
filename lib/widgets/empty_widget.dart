import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Wygląda na to, że nic tutaj nie ma',
        style: TextStyle(color: white, fontSize: 30),
      ),
    );
  }
}
