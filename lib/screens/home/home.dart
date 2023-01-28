import 'package:e_rejestr/screens/home/home_container.dart';
import 'package:e_rejestr/utils/shared_preferences.dart';
import 'package:e_rejestr/view_models/home_view_model.dart';
import 'package:e_rejestr/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: MyAppBar(pageIndex: viewModel.initialRegisterPage),
          ),
          body: const HomeContainer(),
        );
      },
    );
  }
}
