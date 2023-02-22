import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/widgets/select_psychology/title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectPsychologistJudgment extends StatefulWidget {
  const SelectPsychologistJudgment({required this.name, super.key});
  final String name;

  @override
  State<SelectPsychologistJudgment> createState() => _SelectPsychologistJudgmentState();
}

class _SelectPsychologistJudgmentState extends State<SelectPsychologistJudgment> with TickerProviderStateMixin, RestorationMixin {
  bool _selected = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture = RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );
  late final RestorableDateTime _selectedDate;

  late String formatDate;
  late DateTime dateTime;
  String _radioButton = 'brak';
  String _radioDate = 'bezterminowo';
  bool _carA = true;
  bool _carB = false;
  bool _carC = false;

  @override
  String? get restorationId => 'dateSelect';

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now().add(const Duration(days: 365 * 5));
    _selectedDate = RestorableDateTime(DateTime(dateTime.year, dateTime.month, dateTime.day));
    formatDate = DateFormat('dd-MM-yyyy').format(dateTime);
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(_restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        formatDate = DateFormat('dd-MM-yyyy').format(_selectedDate.value);
        _radioDate = formatDate;
      });
    }
  }

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(3000),
        );
      },
    );
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
                  const Text(
                    '** Zaznaczenie jest równoważne z brakiem skreślenia, jest traktowane jako potrzebne **',
                    style: TextStyle(color: white, fontSize: 25),
                    textAlign: TextAlign.left,
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
                  const TitleJudgment(name: 'Kierowane pojazdy: '),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('AM, A1, A2, A, B1, B, B+E, T,'),
                    value: _carA,
                    onChanged: (value) {
                      setState(() {
                        _carA = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('C1, C1+E, C, C+E, D1, D1+E, D, D+E'),
                    value: _carB,
                    onChanged: (value) {
                      setState(() {
                        _carB = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('tramwajem'),
                    value: _carC,
                    onChanged: (value) {
                      setState(() {
                        _carC = value!;
                      });
                    },
                  ),
                  const TitleJudgment(name: 'Data ważności badania: '),
                  RadioListTile(
                    title: const Text('bezterminowo'),
                    value: 'bezterminowo',
                    groupValue: _radioDate,
                    onChanged: (value) {
                      setState(() {
                        _radioDate = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(formatDate),
                    value: formatDate,
                    groupValue: _radioDate,
                    onChanged: (value) {
                      setState(() {
                        _radioDate = value!;
                      });
                    },
                  ),
                  _radioDate != 'bezterminowo'
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: () {
                              _restorableDatePickerRouteFuture.present();
                            },
                            child: const Text('Zmień datę'),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
