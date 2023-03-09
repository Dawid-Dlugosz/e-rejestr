import 'package:e_rejestr/dialogs/settings/settings.dart';
import 'package:e_rejestr/utils/pages.dart';
import 'package:e_rejestr/utils/session.dart';
import 'package:e_rejestr/view_models/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.pageIndex, super.key});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'E-rejestr',
          style: TextStyle(fontSize: 30),
        ),
        Text(
          pageTitle(pageIndex).toUpperCase(),
          style: const TextStyle(fontSize: 25),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ChangeNotifierProvider(create: (_) => SettingsViewModel(), child: const Settings());
                  },
                )
              },
              icon: const Icon(Icons.build),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () => logOut(context),
              icon: const Icon(Icons.logout),
            )
          ],
        ),
      ],
    );
  }
}
