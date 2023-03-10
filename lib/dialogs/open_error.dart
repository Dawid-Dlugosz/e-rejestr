import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';

class OpenError extends StatelessWidget {
  const OpenError({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: lightPurple,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Problem z otworzniem pliku',
              style: TextStyle(fontSize: 25, color: white),
            ),
            SizedBox(height: 10),
            Text(
              'Podejrzyj plik ręcznie z katalogu',
              style: TextStyle(fontSize: 20, color: white),
            ),
          ],
        ),
      ),
    );
  }
}
