import 'package:e_rejestr/dialogs/add_firm.dart';
import 'package:e_rejestr/dialogs/select_patient/patient_header_item.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/view_models/firm_view_model.dart';
import 'package:e_rejestr/widgets/empty_widget.dart';
import 'package:e_rejestr/widgets/firm_list/firm_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class FirmContainer extends StatefulWidget {
  const FirmContainer({super.key});

  @override
  State<FirmContainer> createState() => _FirmContainerState();
}

class _FirmContainerState extends State<FirmContainer> {
  var lastFirmSearch = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<FirmViewModel>(
      builder: (context, viemModel, chidren) {
        return Dialog(
          child: viemModel.loaded
              ? Container(
                  color: lightPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  lastFirmSearch = value;
                                });
                              },
                              decoration: const InputDecoration(
                                label: Text('Wyszukaj po nazwie'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AddFirm(viemModel);
                                },
                              ).then((value) => viemModel.createFirmList());
                            },
                            child: const Text(
                              'Dodaj nową firmę',
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // TODO ZROBIĆ DODAWANIE FIRMY PRZEZ API
                            },
                            child: const Text(
                              'Dodaj firmę z api',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Table(
                          border: TableBorder.all(color: white, style: BorderStyle.solid, width: 2),
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          columnWidths: const {
                            0: FractionColumnWidth(0.1),
                            1: FractionColumnWidth(0.1),
                            2: FractionColumnWidth(0.18),
                            3: FractionColumnWidth(0.18),
                          },
                          children: [
                            TableRow(
                              children: [
                                PatientHeaderItem('Nip'),
                                PatientHeaderItem('Nazwa'),
                                PatientHeaderItem('Adres'),
                                PatientHeaderItem('Akcja'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: viemModel.firms.isNotEmpty
                            ? FirmList(
                                firms: viemModel.firms.where((element) => element.name.contains(lastFirmSearch)).toList(),
                              )
                            : const EmptyWidget(),
                      )
                    ],
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
