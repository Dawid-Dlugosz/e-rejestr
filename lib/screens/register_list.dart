import 'package:e_rejestr/models/register.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/widgets/register_header/header_item.dart';
import 'package:flutter/material.dart';

class RegisterList extends StatelessWidget {
  const RegisterList({required this.registerItems, super.key});
  final List<Register> registerItems;

  List<String> splitOrderSubcomponents(String order) {
    List<String> subcomponents = [];

    String currentSubcomponent = '';
    bool lastIsNumeric = false;

    for (int i = 0; i < order.length; i++) {
      bool isNumeric = int.tryParse(order[i]) != null;

      if (isNumeric == lastIsNumeric) {
        currentSubcomponent += order[i];
      } else {
        subcomponents.add(currentSubcomponent);
        currentSubcomponent = order[i];
        lastIsNumeric = isNumeric;
      }
    }

    subcomponents.add(currentSubcomponent);

    return subcomponents;
  }

  @override
  Widget build(BuildContext context) {
    // Generated code by CHATGTP
    registerItems.sort((a, b) {
      List<String> aParts = a.lp.split('/');
      List<String> bParts = b.lp.split('/');

      String aOrder = aParts[0];
      String bOrder = bParts[0];

      int aMonth = int.parse(aParts[1]);
      int bMonth = int.parse(bParts[1]);

      int aYear = int.parse(aParts[2]);
      int bYear = int.parse(bParts[2]);

      // Compare the components in ascending order: year, month, order
      if (aYear != null && bYear != null && aYear != bYear) {
        return aYear.compareTo(bYear);
      } else if (aMonth != null && bMonth != null && aMonth != bMonth) {
        return aMonth.compareTo(bMonth);
      } else {
        List<String> aOrderSubcomponents = splitOrderSubcomponents(aOrder);
        List<String> bOrderSubcomponents = splitOrderSubcomponents(bOrder);

        for (int i = 0; i < aOrderSubcomponents.length && i < bOrderSubcomponents.length; i++) {
          bool aIsNumeric = int.tryParse(aOrderSubcomponents[i]) != null;
          bool bIsNumeric = int.tryParse(bOrderSubcomponents[i]) != null;

          if (aIsNumeric && bIsNumeric) {
            int aNumber = int.parse(aOrderSubcomponents[i]);
            int bNumber = int.parse(bOrderSubcomponents[i]);

            if (aNumber != bNumber) {
              return aNumber.compareTo(bNumber);
            }
          } else if (aIsNumeric && !bIsNumeric) {
            return -1;
          } else if (!aIsNumeric && bIsNumeric) {
            return 1;
          } else {
            int cmp = aOrderSubcomponents[i].compareTo(bOrderSubcomponents[i]);

            if (cmp != 0) {
              return cmp;
            }
          }
        }

        // If we've compared all subcomponents and they're still equal, compare the lengths of the subcomponents
        return aOrderSubcomponents.length.compareTo(bOrderSubcomponents.length);
      }
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
