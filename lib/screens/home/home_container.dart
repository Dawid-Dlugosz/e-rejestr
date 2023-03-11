import 'package:e_rejestr/screens/home/home_nav.dart';
import 'package:e_rejestr/view_models/home_view_model.dart';
import 'package:e_rejestr/widgets/menu_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    return Consumer<HomeViewModel>(builder: (context, viewModel, _) {
      return Row(
        children: [
          const Expanded(
            flex: 1,
            child: HomeNav(),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: MenuContainer(homeViewModel.initialRegisterPage),
            ),
          ),
        ],
      );
    });
  }
}
