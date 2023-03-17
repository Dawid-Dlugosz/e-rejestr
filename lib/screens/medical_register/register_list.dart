import 'package:e_rejestr/models/register.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/widgets/register_header/header_item.dart';
import 'package:flutter/material.dart';

class RegisterList extends StatelessWidget {
  const RegisterList({required this.registerItems, super.key});
  final List<Register> registerItems;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: white, style: BorderStyle.solid, width: 2),
        columnWidths: const {
          0: FractionColumnWidth(0.05),
          1: FractionColumnWidth(0.2),
          2: FractionColumnWidth(0.2),
          3: FractionColumnWidth(0.2),
          4: FractionColumnWidth(0.1),
          5: FractionColumnWidth(0.1),
          6: FractionColumnWidth(0.1),
        },
        children: [
          ...registerItems.map(
            (e) => TableRow(
              children: [
                HeaderItem(e.lp),
                HeaderItem(e.getNameAndAddress()),
                HeaderItem(e.documentNumber),
                HeaderItem(e.getFormatedArticels()),
                const HeaderItem(''),
                HeaderItem(e.releaseDate),
                const HeaderItem(''),
              ],
            ),
          )
        ],
      ),
    );
  }
}
