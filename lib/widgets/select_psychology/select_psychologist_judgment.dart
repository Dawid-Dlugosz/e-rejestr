import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/judgments.dart';
import 'package:e_rejestr/widgets/select_psychology/cars_category.dart';
import 'package:e_rejestr/widgets/select_psychology/expiration_date.dart';
import 'package:e_rejestr/widgets/select_psychology/title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectPsychologistJudgment extends StatefulWidget {
  const SelectPsychologistJudgment({required this.name, super.key});
  final String name;

  @override
  State<SelectPsychologistJudgment> createState() => _SelectPsychologistJudgmentState();
}

class _SelectPsychologistJudgmentState extends State<SelectPsychologistJudgment> with TickerProviderStateMixin {
  bool _selected = false;

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
    });
  }

  void updateCar(String car, bool value) {
    switch (car) {
      case 'A':
        setState(() {
          _carA = value;
        });
        break;
      case 'B':
        setState(() {
          _carB = value;
        });
        break;
      case 'C':
        setState(() {
          _carC = value;
        });
        break;
    }
  }

  // TODO ZROBIĆ WYJĄTKI DLA 39 I UPRZYWILEJOWANEGO Z WORDA, TEŻ PRZEJŻEĆ CZY JEST ON PRZEROBIONY W PDF, ORAZ DOSTOSOWĄC GÓWNO INSTRUKTORA EGZAMINATORA
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
            value: _selected,
            onChanged: (value) {
              setState(() {
                _selected = value!;
                if (_selected) {
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
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('brak'),
                    value: 'brak',
                    groupValue: _radioButton,
                    onChanged: (value) {
                      setState(() {
                        _radioButton = value!;
                      });
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
