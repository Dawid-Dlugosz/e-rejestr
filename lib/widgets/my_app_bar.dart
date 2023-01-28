import 'package:e_rejestr/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

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
        IconButton(
          onPressed: () => logOut(context),
          icon: const Icon(Icons.logout),
        )
      ],
    );
  }
}
