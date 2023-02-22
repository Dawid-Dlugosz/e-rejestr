import 'package:e_rejestr/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterMenu extends StatelessWidget {
  const RegisterMenu({required this.onTextChange, super.key});
  final Function(String text) onTextChange;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: const TextField(
                      decoration: InputDecoration(
                        label: Text('Wyszukaj po nazwisku'),
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO ZROBIĆ DRUKOWANIE REJESTU Z WYBOREM DATY POCZĄTKOWEJ I KOŃCOWEJ
                },
                child: const Text('Drukuj rejestr'),
              )
            ],
          ),
        );
      },
    );
  }
}
