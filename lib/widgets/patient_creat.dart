import 'package:e_rejestr/view_models/patient_create_view_model.dart';
import 'package:e_rejestr/widgets/error_text.dart';
import 'package:e_rejestr/widgets/underline_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PatientCreate extends StatefulWidget {
  const PatientCreate({this.changeScreen, super.key});

  final Function(bool value)? changeScreen;

  @override
  State<PatientCreate> createState() => _PatientCreateState();
}

class _PatientCreateState extends State<PatientCreate> {
  final _formKey = GlobalKey<FormState>();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientCreateViewModel>(
      builder: (context, viewModel, _) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.changeScreen != null
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: () => widget.changeScreen!(false),
                          child: const Text('Powrót do wyboru z listy'),
                        ),
                      )
                    : Container(),
                UnderLineTextField(
                  title: 'Imię *',
                  hint: 'Jan',
                  controller: viewModel.nameController,
                ),
                UnderLineTextField(
                  title: 'Nazwisko *',
                  hint: 'Kowalski',
                  controller: viewModel.lastNameController,
                ),
                UnderLineTextField(
                  title: 'Kod pocztowy i Miejscowość *',
                  hint: '08-110 Siedlce',
                  mask: viewModel.postalMask,
                  controller: viewModel.domicileController,
                ),
                UnderLineTextField(
                  title: 'Ulica nr. domu / mieszkanie *',
                  hint: 'Poniatowskiego 3/5',
                  controller: viewModel.streetController,
                ),
                UnderLineTextField(
                  title: 'Data urodzenia *',
                  hint: 'DD-MM-RRRR',
                  mask: viewModel.birthdayMask,
                  controller: viewModel.birthayController,
                ),
                UnderLineTextField(
                  title: 'Pesel',
                  mask: FilteringTextInputFormatter.digitsOnly,
                  inputType: TextInputType.number,
                  controller: viewModel.peselController,
                ),
                UnderLineTextField(
                  title: 'Numer dokumentu',
                  controller: viewModel.documentNumberController,
                ),
                ErrorText(text: errorText),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (!viewModel.checkBasicData()) {
                          setState(() {
                            errorText = 'Wypełnij pola oznaczone *';
                          });
                          return;
                        }

                        if (!viewModel.checkExtraDate()) {
                          setState(() {
                            errorText = 'Uzupełnij pesel lub numer dokumentu';
                          });
                          return;
                        }

                        if (!viewModel.peselValidator() && viewModel.peselController.text.isNotEmpty) {
                          setState(() {
                            errorText = 'Podaj poprawny numer pesel';
                          });
                          return;
                        }
                        await viewModel.inserData(clear: true);

                        setState(() {
                          errorText = null;
                        });
                      },
                      child: const Text('Zapisz'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Zapisz i wybierz'),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
