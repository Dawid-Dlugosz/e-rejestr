import 'package:e_rejestr/models/firm.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/view_models/firm_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddFirm extends StatelessWidget {
  AddFirm(this.firmViewModel, {this.firm, super.key});

  final FirmViewModel firmViewModel;
  Firm? firm;
  @override
  Widget build(BuildContext context) {
    var nipController = TextEditingController();
    var nameController = TextEditingController();
    var addressController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    if (firm != null) {
      nipController.text = firm!.nip;
      addressController.text = firm!.address;
      nameController.text = firm!.name;
    }

    return Dialog(
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 100,
        ),
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.3,
        color: lightPurple,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nipController,
                decoration: const InputDecoration(
                  label: Text('Nip'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Podaj nip';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('Nazwa'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Podaj nazwę';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  label: Text('Adres'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Podaj adres';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    if (firm != null) {
                      var updateFirm = Firm(
                        address: addressController.text,
                        nip: nipController.text,
                        name: nameController.text,
                        id: firm!.id,
                      );
                      await firmViewModel.updateFirm(updateFirm);
                      Navigator.pop(context, firm);
                    } else {
                      var firm = Firm(
                        address: addressController.text,
                        nip: nipController.text,
                        name: nameController.text,
                        id: const Uuid().v4(),
                      );
                      await firmViewModel.createFirm(firm);
                      Navigator.pop(context, firm);
                    }
                  }
                },
                child: const Text('Zapisz i zamknij'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
