import 'package:flutter/material.dart';
import 'package:mobigic_test/core/colors/color.dart';
import 'package:mobigic_test/core/strings/strings.dart';
import 'package:mobigic_test/screens/grid_creation_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    goToHome(context);
    return Scaffold(
      backgroundColor: kBlack,
      body: Center(
          child: SizedBox(
        height: 130,
        width: 130,
        child: Image.asset(splashImage),
      )),
    );
  }

  void goToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const GridCreationScreen(),
          ),
        );
      },
    );
  }
}
