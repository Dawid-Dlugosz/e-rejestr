import 'package:e_rejestr/screens/login.dart';
import 'package:e_rejestr/utils/colors.dart';
import 'package:e_rejestr/utils/theme_data.dart';
import 'package:e_rejestr/view_models/login_view_model.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// const apiKey = 'AIzaSyBZgKgGev3O_oLm_sKLyM1lfL62D_Mjs5k';
const projectId = 'e-rejestr';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: firebaseOptionsDefault);

  Firestore.initialize(projectId);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      home: ChangeNotifierProvider(
        create: (context) => LoginViewModel(context),
        child: const Login(),
      ),
    );
  }
}
