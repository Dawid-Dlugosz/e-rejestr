import 'package:e_rejestr/dialogs/firm_container.dart';
import 'package:e_rejestr/interfaces/medical_judgment_interface.dart';
import 'package:e_rejestr/models/firm.dart';
import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/models/medical_judgment.dart';
import 'package:e_rejestr/models/medicine.dart';
import 'package:e_rejestr/models/patient.dart';
import 'package:e_rejestr/models/residental_address.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/utils/pages.dart';
import 'package:e_rejestr/view_models/firm_view_model.dart';
import 'package:e_rejestr/widgets/select_medical/cars_category_medical.dart';
import 'package:e_rejestr/widgets/select_medical/limitation.dart';
import 'package:e_rejestr/widgets/select_medical/select_date_checkbox_c.dart';
import 'package:e_rejestr/widgets/select_medicine/type_medical.dart';
import 'package:e_rejestr/widgets/select_psychology/expiration_date.dart';
import 'package:e_rejestr/widgets/select_psychology/title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectMedicineJudgment extends StatefulWidget {
  SelectMedicineJudgment({required this.name, required this.addRemoveJudgment, required this.updateJudgment, required this.select, required this.firm, required this.setFirm, super.key});
  final String name;
  Firm? firm;
  final Function(MedicaJudgmentInterface judgment) addRemoveJudgment;
  final Function(MedicaJudgmentInterface judgment) updateJudgment;
  final Function(Firm firm) setFirm;
  bool select;

  @override
  State<SelectMedicineJudgment> createState() => _SelectMedicineJudgmentState();
}

class _SelectMedicineJudgmentState extends State<SelectMedicineJudgment> with TickerProviderStateMixin {
  late Medicine medicineJudgment;
  late String dateOfIssue;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  String _radioDate = 'bezterminowo';
  bool _checkboxA = true;
  bool _checkboxB = true;
  bool _checkboxC = false;
  String _typeMedical = 'Wstępne';
  String _checkboxCDate = '';
  String _workPosition = '';
  @override
  void initState() {
    super.initState();
    var currentDate = DateTime.now();
    dateOfIssue = DateFormat('dd-MM-yyyy').format(currentDate);
    _createJudgment();
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  void _createJudgment() {
    var emptyPatient = Patient(
      firstName: '',
      lastName: '',
      residentialAddress: ResidentialAddress(postCodeCity: '', street: ''),
      birthday: '',
      uid: '',
    );

    medicineJudgment = Medicine(
      judgmentName: widget.name,
      article: getJudgmentArticle(widget.name),
      pdf: widget.name,
      dateOfIssue: dateOfIssue,
      dateOfValidity: _radioDate,
      patient: emptyPatient,
      number: '',
      checkboxA: _checkboxA,
      checkboxB: _checkboxB,
      checkboxC: _checkboxC,
      typeMedical: _typeMedical,
      firm: widget.firm!,
      checkboxCDate: _checkboxCDate,
      workPosition: _workPosition,
    );
  }

  void updateRadio(String value) {
    setState(() {
      _radioDate = value;
      medicineJudgment.dateOfValidity = _radioDate;
    });

    widget.updateJudgment(medicineJudgment);
  }

  void updateCheckboxCDate(String value) {
    setState(() {
      _checkboxCDate = value;
      medicineJudgment.checkboxCDate = _checkboxCDate;
    });

    widget.updateJudgment(medicineJudgment);
  }

  void updateType(String value) {
    setState(() {
      _typeMedical = value;
      medicineJudgment.typeMedical = _typeMedical;
    });

    widget.updateJudgment(medicineJudgment);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: white, width: 3),
      ),
      child: Column(
        children: [
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              widget.name,
              style: const TextStyle(fontSize: 23),
            ),
            value: widget.select,
            onChanged: (value) {
              setState(() {
                widget.addRemoveJudgment(medicineJudgment);
                widget.select = value!;
                if (widget.select) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              });
            },
          ),
          SizeTransition(
            sizeFactor: _animation,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      '** Zaznaczenie jest równoważne z brakiem skreślenia, jest traktowane jako potrzebne **',
                      style: TextStyle(color: white, fontSize: 25),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  widget.name == medicalMedycynaPracy
                      ? TypMedical(
                          typeMedical: _typeMedical,
                          updateType: updateType,
                        )
                      : Container(),
                  TextField(
                    decoration: InputDecoration(label: const Text('Stanowisko pracy')),
                    onChanged: (value) {
                      setState(() {
                        _workPosition = value;
                      });
                      medicineJudgment.workPosition = _workPosition;
                      widget.updateJudgment(medicineJudgment);
                    },
                  ),
                  const TitleJudgment(name: 'Przeciwskazania:'),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                      'wobec brakuprzeciwwskazańzdrowotnychjest zdolny(-na) do wykonywania/podjęcia*) pracynaokreślonym stanowisku(symbol 21)*)',
                      style: TextStyle(fontSize: 17),
                    ),
                    value: _checkboxA,
                    onChanged: (value) {
                      setState(() {
                        _checkboxA = value!;
                      });
                      widget.updateJudgment(medicineJudgment);
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text(
                      'wobec istnienia przeciwwskazańzdrowotnychjestniezdolny(-na) do wykonywania/podjęcia*) pracyna określonym stanowisku(symbol 22)*)',
                      style: TextStyle(fontSize: 17),
                    ),
                    value: _checkboxB,
                    onChanged: (value) {
                      setState(() {
                        _checkboxB = value!;
                      });
                      widget.updateJudgment(medicineJudgment);
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      ' wobec stnienia przeciwwskazańzdrowotnychutracił(a) zdolność do wykonywania dotychczasowej pracy z dniem  $_checkboxCDate (symbol 23)*)',
                      style: const TextStyle(fontSize: 17),
                    ),
                    value: _checkboxC,
                    onChanged: (value) {
                      setState(() {
                        _checkboxC = value!;
                        if (!_checkboxC) {
                          _checkboxCDate = '';
                        }
                      });
                      widget.updateJudgment(medicineJudgment);
                    },
                  ),
                  _checkboxC
                      ? SelectDateCheckboxC(
                          judgmentName: widget.name,
                          checkboxCDate: _checkboxCDate,
                          updateCheckboxCDate: updateCheckboxCDate,
                        )
                      : Container(),
                  ExpirationDate(
                    judgmentName: widget.name,
                    radioDate: _radioDate,
                    updateRadio: updateRadio,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
