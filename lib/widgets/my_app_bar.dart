import 'package:e_rejestr/utils/pages.dart';
import 'package:e_rejestr/utils/session.dart';
import 'package:flutter/material.dart';

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
        IconButton(
          onPressed: () => logOut(context),
          icon: const Icon(Icons.logout),
        )
      ],
    );
  }
}
