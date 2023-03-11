import 'package:e_rejestr/models/firm.dart';
import 'package:e_rejestr/widgets/firm_list/firm_list_item.dart';
import 'package:flutter/widgets.dart';

class FirmList extends StatelessWidget {
  FirmList({required this.firms, super.key});
  List<Firm> firms;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: FractionColumnWidth(0.02),
            1: FractionColumnWidth(0.07),
            2: FractionColumnWidth(0.18),
          },
          children: [
            ...firms
                .map(
                  (e) => TableRow(
                    children: [
                      FirmListItem(e),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
