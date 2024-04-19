import 'package:admin/Screens/Donation%20Form.dart';
import 'package:admin/Screens/Done%20tasks.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens/Home_page.dart';
import 'Screens/Resgister_page.dart';
import 'Screens/auth.dart';
import 'Screens/contat us.dart';
import 'Screens/tasks.dart';
import 'Screens/login_page.dart';
import 'Screens/request.dart';
import 'Screens/splash screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        routes: {
          'Splash': (context) => Splash(),
          'Auth':(context)=>Auth(),
          'Login': (context) => Login(),
          'Resgister': (context) => Resgister(),
          'Home': (context) => HomePage(),
          'history':(context)=>tasks(),
          'request':(context)=>request(),
          'contactUs':(context)=>ContactUsPage(),
          'DonationForm':(context)=>DonationForm(),
          'donetasks':(context)=>donetasks(),

        },
        debugShowCheckedModeBanner: false,
        home:Splash(),
      ),
    );
  }
}
