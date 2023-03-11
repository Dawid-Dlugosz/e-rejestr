import 'package:e_rejestr/widgets/select_psychology/title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpirationDate extends StatefulWidget {
  ExpirationDate({required this.judgmentName, required this.radioDate, required this.updateRadio, super.key});

  String radioDate;
  final String judgmentName;
  final Function(String value) updateRadio;

  @override
  State<ExpirationDate> createState() => _ExpirationDateState();
}

class _ExpirationDateState extends State<ExpirationDate> with RestorationMixin {
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

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now().add(const Duration(days: 365 * 5));
    _selectedDate = RestorableDateTime(DateTime(dateTime.year, dateTime.month, dateTime.day));
    formatDate = DateFormat('dd-MM-yyyy').format(dateTime);
  }

  @override
  String? get restorationId => "${widget.judgmentName} DatePicker";

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
        widget.updateRadio(formatDate);
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
          lastDate: DateTime(2060),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleJudgment(name: 'Data ważności badania: '),
        RadioListTile(
          title: const Text('bezterminowo'),
          value: 'bezterminowo',
          groupValue: widget.radioDate,
          onChanged: (value) {
            widget.updateRadio(value!);
          },
        ),
        RadioListTile(
          title: Text(formatDate),
          value: formatDate,
          groupValue: widget.radioDate,
          onChanged: (value) {
            widget.updateRadio(value!);
          },
        ),
        widget.radioDate != 'bezterminowo'
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
    );
  }
}
