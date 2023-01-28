import 'package:e_rejestr/screens/login.dart';
import 'package:e_rejestr/utils/shared_preferences.dart';
import 'package:e_rejestr/view_models/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> logOut(BuildContext context) async {
  resetSession();
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => LoginViewModel(context),
        child: const Login(),
      ),
    ),
  );
}
