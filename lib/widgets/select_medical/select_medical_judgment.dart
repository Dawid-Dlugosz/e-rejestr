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
import 'package:e_rejestr/widgets/select_psychology/expiration_date.dart';
import 'package:e_rejestr/widgets/select_psychology/title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SelectMedicalJudgment extends StatefulWidget {
  SelectMedicalJudgment({required this.name, required this.addRemoveJudgment, required this.updateJudgment, required this.select, super.key});
  final String name;
  final Function(MedicaJudgmentInterface judgment) addRemoveJudgment;
  final Function(MedicaJudgmentInterface judgment) updateJudgment;
  bool select;

  @override
  State<SelectMedicalJudgment> createState() => _SelectMedicalJudgmentState();
}

class _SelectMedicalJudgmentState extends State<SelectMedicalJudgment> with TickerProviderStateMixin {
  // late MedicaJudgmentInterface medicalJudgment;
  late MedicalJudgment medicalJudgment;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  String _radioButton = 'brak';
  String _radioDate = 'bezterminowo';
  bool _carA = true;
  bool _carB = false;
  bool _carC = false;
  bool _carD = false;
  bool limitA = true;
  bool limitB = true;

  @override
  void initState() {
    var currentDate = DateTime.now();
    var dateOfIssue = DateFormat('dd-MM-yyyy').format(currentDate);
    var emptyPatient = Patient(
      firstName: '',
      lastName: '',
      residentialAddress: ResidentialAddress(postCodeCity: '', street: ''),
      birthday: '',
      uid: '',
    );

    medicalJudgment = MedicalJudgment(
      state: _radioButton,
      carA: _carA,
      carB: _carB,
      carC: _carC,
      carD: _carD,
      limitA: limitA,
      limitB: limitB,
      judgmentName: widget.name,
      article: getJudgmentArticle(widget.name),
      pdf: widget.name,
      dateOfIssue: dateOfIssue,
      dateOfValidity: _radioDate,
      patient: emptyPatient,
      number: '',
    );
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  void updateCar(String car, bool value) {
    switch (car) {
      case 'A':
        setState(() {
          _carA = value;
          medicalJudgment.carA = _carA;
        });
        break;
      case 'B':
        setState(() {
          _carB = value;
          medicalJudgment.carB = _carB;
        });
        break;
      case 'C':
        setState(() {
          _carC = value;
          medicalJudgment.carC = _carC;
        });
        break;
      case 'D':
        setState(() {
          _carD = value;
          medicalJudgment.carD = _carD;
        });
        break;
    }
    widget.updateJudgment(medicalJudgment);
  }

  void updateRadio(String value) {
    setState(() {
      _radioDate = value;
      medicalJudgment.dateOfValidity = _radioDate;
    });

    widget.updateJudgment(medicalJudgment);
  }

  void updateLimit(String limit, bool value) {
    switch (limit) {
      case 'A':
        setState(() {
          limitA = value;
          medicalJudgment.limitA = limitA;
        });
        break;
      case 'B':
        setState(() {
          limitB = value;
          medicalJudgment.limitB = limitB;
        });
        break;
    }
    widget.updateJudgment(medicalJudgment);
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
                widget.addRemoveJudgment(medicalJudgment);
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
                  const TitleJudgment(name: 'Przeciwwskazania: '),
                  RadioListTile(
                    title: const Text('istnieje'),
                    value: 'istnieje',
                    groupValue: _radioButton,
                    onChanged: (value) {
                      setState(() {
                        _radioButton = value!;
                        medicalJudgment.state = _radioButton;
                      });

                      widget.updateJudgment(medicalJudgment);
                    },
                  ),
                  RadioListTile(
                    title: const Text('brak'),
                    value: 'brak',
                    groupValue: _radioButton,
                    onChanged: (value) {
                      setState(() {
                        _radioButton = value!;
                        medicalJudgment.state = _radioButton;
                      });
                      widget.updateJudgment(medicalJudgment);
                    },
                  ),
                  CarsCategoryMedicial(
                    judgmentName: widget.name,
                    carA: medicalJudgment.carA,
                    carB: medicalJudgment.carB,
                    carC: medicalJudgment.carC,
                    carD: medicalJudgment.carD,
                    updateCar: updateCar,
                  ),
                  Limitation(
                    medicalJudgment: medicalJudgment,
                    updateLimit: updateLimit,
                  ),
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
