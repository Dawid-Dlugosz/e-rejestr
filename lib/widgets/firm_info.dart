import 'package:e_rejestr/models/firm.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';

class FirmInfo extends StatelessWidget {
  const FirmInfo(this.firm, this.clearFirm, {super.key});
  final Firm firm;
  final VoidCallback clearFirm;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nazwa firmy: ${firm.name}',
          style: const TextStyle(color: white, fontSize: 25),
        ),
        Text(
          'Nr. nip: ${firm.nip}',
          style: const TextStyle(color: white, fontSize: 25),
        ),
        Text(
          'Adres firmy: ${firm.address}',
          style: const TextStyle(color: white, fontSize: 25),
        ),
        ElevatedButton(
          onPressed: clearFirm,
          child: const Text('Wyczyść firmę'),
        )
      ],
    );
  }
}
