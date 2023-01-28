import 'package:e_rejestr/screens/home/home.container.dart';
import 'package:e_rejestr/utils/shared_preferences.dart';
import 'package:e_rejestr/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const MyAppBar(),
        ),
        body: HomeContainer());
    //   return ElevatedButton(
    //     onPressed: () async {
    //       resetSession();
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => ChangeNotifierProvider(
    //             create: (context) => LoginViewModel(context),
    //             child: Login(),
    //           ),
    //         ),
    //       );
    //     },
    //     child: Text('Log out'),
    //   );
    // }
  }
}
