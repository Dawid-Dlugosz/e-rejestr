import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/widgets/register_header/header_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: white, style: BorderStyle.solid, width: 2),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FractionColumnWidth(0.05),
        1: FractionColumnWidth(0.2),
        2: FractionColumnWidth(0.2),
        3: FractionColumnWidth(0.2),
        4: FractionColumnWidth(0.1),
        5: FractionColumnWidth(0.1),
        6: FractionColumnWidth(0.1),
      },
      children: const [
        TableRow(
          children: [
            HeaderItem('Lp'),
            HeaderItem('Imię i nazwisko, adres zamieszkania osoby badanej'),
            HeaderItem('Nr PESEL \n a w przypadku osoby której nie ma nadanego nr PESEL - nazwa i numer dokumentu tożsamości'),
            HeaderItem('Określenie rodzaju wydanego orzeczenia wraz z podaniem kategorii prawa jazdy'),
            HeaderItem('Uwagi'),
            HeaderItem('Data wydania'),
            HeaderItem('Potwierdzenie odbioru'),
          ],
        ),
      ],
    );
  }
}
