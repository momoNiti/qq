import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash.jpg',
          key: const Key("Splash BG"),
          width: 150,
        ),
      ),
    );
  }
}
