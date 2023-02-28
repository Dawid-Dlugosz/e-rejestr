import 'package:e_rejestr/models/judgment.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/widgets/select_psychology/cars_category.dart';
import 'package:e_rejestr/widgets/select_psychology/expiration_date.dart';
import 'package:e_rejestr/widgets/select_psychology/title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectPsychologistJudgment extends StatefulWidget {
  SelectPsychologistJudgment({required this.name, required this.addRemoveJudgment, required this.updateJudgment, required this.select, super.key});
  final String name;
  final Function(Judgment judgment) addRemoveJudgment;
  final Function(Judgment judgment) updateJudgment;
  bool select;

  @override
  State<SelectPsychologistJudgment> createState() => _SelectPsychologistJudgmentState();
}

class _SelectPsychologistJudgmentState extends State<SelectPsychologistJudgment> with TickerProviderStateMixin {
  late Judgment judgment;
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

  void updateRadio(String value) {
    setState(() {
      _radioDate = value;
      judgment.termOfValidyty = _radioDate;
    });

    widget.updateJudgment(judgment);
  }

  void updateCar(String car, bool value) {
    switch (car) {
      case 'A':
        setState(() {
          _carA = value;
          judgment.carA = _carA;
        });
        break;
      case 'B':
        setState(() {
          _carB = value;
          judgment.carB = _carB;
        });
        break;
      case 'C':
        setState(() {
          _carC = value;
          judgment.carC = _carC;
        });
        break;
    }
    widget.updateJudgment(judgment);
  }

  @override
  void initState() {
    var currentDate = DateTime.now();
    var dateOfIssue = DateFormat('dd-MM-yyyy').format(currentDate);

    judgment = Judgment(
      judgmentName: widget.name,
      number: '',
      article: getJudgmentArticle(widget.name),
      patientName: '',
      document: '',
      residence: '',
      state: _radioButton,
      carA: _carA,
      carB: _carB,
      carC: _carC,
      termOfValidyty: _radioDate,
      dateOfIssue: dateOfIssue,
      pdf: widget.name,
    );

    super.initState();
  }

  @override
  dispose() {
    _controller.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.select) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
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
                widget.addRemoveJudgment(judgment);
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
                        judgment.state = _radioButton;
                      });

                      widget.updateJudgment(judgment);
                    },
                  ),
                  RadioListTile(
                    title: const Text('brak'),
                    value: 'brak',
                    groupValue: _radioButton,
                    onChanged: (value) {
                      setState(() {
                        _radioButton = value!;
                        judgment.state = _radioButton;
                      });
                      widget.updateJudgment(judgment);
                    },
                  ),
                  widget.name != judgment39
                      ? CarsCategory(
                          carA: _carA,
                          carB: _carB,
                          carC: _carC,
                          judgmentName: widget.name,
                          updateCar: updateCar,
                        )
                      : Container(),
                  ExpirationDate(
                    judgmentName: widget.name,
                    radioDate: _radioDate,
                    updateRadio: updateRadio,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
