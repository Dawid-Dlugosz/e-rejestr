import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/pages.dart';
import 'package:e_rejestr/view_models/home_view_model.dart';
import 'package:e_rejestr/widgets/home_nav_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({super.key});

  @override
  Widget build(BuildContext context) {
    var homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: white,
            width: 3.0,
          ),
        ),
      ),
      child: Column(
        children: [
          HomeNavButton(
            text: 'Rejestr lekarski'.toUpperCase(),
            onTap: () => homeViewModel.changeScreenRecord(medicalRegister),
          ),
          HomeNavButton(
            text: 'Rejestr psychologiczny'.toUpperCase(),
            onTap: () => homeViewModel.changeScreenRecord(psychologicalRegister),
          ),
        ],
      ),
    );
  }
}
