import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';

class FilePath extends StatelessWidget {
  const FilePath({required this.filePath, required this.changeFielPaht, super.key});
  final String filePath;
  final VoidCallback changeFielPaht;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ścieżka zapisu plików:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: white),
          ),
          Row(
            children: [
              Text(
                filePath,
                style: const TextStyle(fontSize: 18, color: white),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async => changeFielPaht(),
                child: const Text('Zmień ścieżkę'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
