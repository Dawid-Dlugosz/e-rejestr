import 'package:e_rejestr/pdf/psychologist/psychologist_39.dart';
import 'package:e_rejestr/screens/home/home.dart';
import 'package:e_rejestr/screens/login.dart';
import 'package:e_rejestr/utils/shared_preferences.dart';
import 'package:e_rejestr/utils/theme_data.dart';
import 'package:e_rejestr/view_models/home_view_model.dart';
import 'package:e_rejestr/view_models/login_view_model.dart';
import 'package:e_rejestr/view_models/medical_register_view_model.dart';
import 'package:e_rejestr/screens/psychological_register.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
    return MultiProvider(
      providers: [
        Provider<MedicalRegisterViewModel>(
          create: (_) => MedicalRegisterViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themeData,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('pl', 'PL'),
        ],
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
                return ChangeNotifierProvider(
                  create: (context) => HomeViewModel(),
                  child: const Home(),
                );
              }
            }
            // Session Date is null
            return ChangeNotifierProvider(
              create: (context) => LoginViewModel(context),
              child: const Login(),
            );
          },
        ),
      ),
    );
  }
}
