import 'package:e_rejestr/enums/documents.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/pages.dart';
import 'package:e_rejestr/view_models/register_print.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrintRegister extends StatefulWidget {
  const PrintRegister(this.page, {super.key});
  final int page;
  @override
  State<PrintRegister> createState() => _PrintRegisterState();
}

class _PrintRegisterState extends State<PrintRegister> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterPrint(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        width: MediaQuery.of(context).size.width * 0.5,
        color: lightPurple,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                StartDate(),
                EndDate(),
              ],
            ),
            const SizedBox(height: 20),
            Consumer<RegisterPrint>(
              builder: (context, value, child) {
                return value.loaded
                    ? const SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await value.generateRegister(widget.page == medicalRegister ? DocumentType.medical : DocumentType.psycho, context);
                          },
                          child: const Text('Drukuj rejestr'),
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}

class StartDate extends StatefulWidget {
  const StartDate({super.key});
  @override
  State<StartDate> createState() => _StartDateState();
}

class _StartDateState extends State<StartDate> {
  Future<void> _selectDate(BuildContext context, {required DateTime selecteDate}) async {
    showDatePicker(
      context: context,
      initialDate: selecteDate,
      firstDate: DateTime(DateTime.now().year, 1, 1),
      locale: const Locale('pl', 'PL'),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: darkPurple, // <-- SEE HERE
              shadow: lightPurple,
              onPrimary: orange, // <-- SEE HERE
              onSurface: orange, // <-- SEE HERE
            ),
            dialogBackgroundColor: lightPurple,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        var registerPrint = Provider.of<RegisterPrint>(context, listen: false);
        setState(() {
          registerPrint.startDate = DateTime(value.year, value.month, value.day, 0, 0, 0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterPrint>(
      builder: (context, value, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Wybierz datę początkową',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(
                context,
                selecteDate: value.startDate,
              ),
              child: Text(value.getFormatedDate(value.startDate)),
            ),
          ],
        );
      },
    );
  }
}

class EndDate extends StatefulWidget {
  const EndDate({super.key});

  @override
  State<EndDate> createState() => _EndDateState();
}

class _EndDateState extends State<EndDate> {
  Future<void> _selectDate(BuildContext context, {required DateTime selecteDate}) async {
    showDatePicker(
      context: context,
      initialDate: selecteDate,
      firstDate: DateTime(DateTime.now().year, 1, 1),
      locale: const Locale('pl', 'PL'),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: darkPurple, // <-- SEE HERE
              shadow: lightPurple,
              onPrimary: orange, // <-- SEE HERE
              onSurface: orange, // <-- SEE HERE
            ),
            dialogBackgroundColor: lightPurple,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        var registerPrint = Provider.of<RegisterPrint>(context, listen: false);
        setState(() {
          registerPrint.endDate = DateTime(value.year, value.month, value.day, 23, 59, 59);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterPrint>(
      builder: (context, value, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Wybierz datę końcową',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(
                context,
                selecteDate: value.endDate,
              ),
              child: Text(value.getFormatedDate(value.endDate)),
            ),
          ],
        );
      },
    );
  }
}
