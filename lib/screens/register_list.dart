import 'package:e_rejestr/models/register.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/widgets/register_header/header_item.dart';
import 'package:flutter/material.dart';

class RegisterList extends StatelessWidget {
  const RegisterList({required this.registerItems, super.key});
  final List<Register> registerItems;

  @override
  Widget build(BuildContext context) {
    registerItems.sort((a, b) {
      var aParts = a.lp.split('/').map(int.parse).toList();
      var bParts = b.lp.split('/').map(int.parse).toList();
      for (var i = 2; i >= 0; i--) {
        var cmp = aParts[i].compareTo(bParts[i]);
        if (cmp != 0) {
          return cmp;
        }
      }
      return 0;
    });

    return SingleChildScrollView(
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(color: white, style: BorderStyle.solid, width: 2),
        columnWidths: const {
          0: FractionColumnWidth(0.05),
          1: FractionColumnWidth(0.2),
          2: FractionColumnWidth(0.2),
          3: FractionColumnWidth(0.2),
          4: FractionColumnWidth(0.05),
          5: FractionColumnWidth(0.07),
          6: FractionColumnWidth(0.08),
          7: FractionColumnWidth(0.1),
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
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Edytuj'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Podgląd'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
