import 'package:e_rejestr/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class SelectDateCheckboxC extends StatefulWidget {
  SelectDateCheckboxC({required this.judgmentName, required this.checkboxCDate, required this.updateCheckboxCDate, super.key});
  String checkboxCDate;
  final String judgmentName;
  final Function(String value) updateCheckboxCDate;
  @override
  State<SelectDateCheckboxC> createState() => _SelectDateCheckboxCState();
}

class _SelectDateCheckboxCState extends State<SelectDateCheckboxC> with RestorationMixin {
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
    dateTime = DateTime.now().add(const Duration(days: 365 * 5));
    _selectedDate = RestorableDateTime(DateTime(dateTime.year, dateTime.month, dateTime.day));
    formatDate = DateFormat('dd-MM-yyyy').format(dateTime);

    super.initState();
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
        widget.updateCheckboxCDate(formatDate);
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
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(
          'Data: ${formatDate}',
          style: const TextStyle(
            color: white,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: () {
            _restorableDatePickerRouteFuture.present();
          },
          child: const Text('Zmień datę'),
        )
      ],
    );
  }
}
