import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigateToHome(context, 'Login');
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'assets/splash.png',
            fit: BoxFit.fill,
          ),
        ));
  }

  void NavigateToHome(BuildContext context, String ScreenName) {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, ScreenName);
    });
  } //NavigateToHome
}
