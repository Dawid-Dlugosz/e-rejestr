import 'package:e_rejestr/screens/home.dart';
import 'package:e_rejestr/screens/login.dart';
import 'package:e_rejestr/utils/shared_preferences.dart';
import 'package:e_rejestr/utils/theme_data.dart';
import 'package:e_rejestr/view_models/login_view_model.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const apiKey = 'AIzaSyBZgKgGev3O_oLm_sKLyM1lfL62D_Mjs5k';
const projectId = 'e-rejestr';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.initialize(projectId);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      // Get timestamp session session duration is one day
      home: FutureBuilder<int?>(
        future: getSession(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var sessionDate = DateTime.fromMillisecondsSinceEpoch(snapshot.data!);
            var currentDate = DateTime.now();
            // if current date is after session date, delete session and return to login page
            if (currentDate.compareTo(sessionDate) > 0) {
              return FutureBuilder<bool>(
                future: resetSession(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ChangeNotifierProvider(
                      create: (context) => LoginViewModel(context),
                      child: const Login(),
                    );
                  }
                  return Container();
                },
              );
            } else {
              // If curretDate is before Session Date show home page
              return const Home();
            }
          }
          // Session Date is null
          return ChangeNotifierProvider(
            create: (context) => LoginViewModel(context),
            child: const Login(),
          );
        },
      ),
    );
  }
}
