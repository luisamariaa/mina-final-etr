import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:mad_final_project/Screens/WelcomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        const Duration(
            seconds: 5), // Adjust  the  duration according to requirements.
        // For Navigation
        () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => WelcomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 223, 176, 231),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/Assets/Images/mad_logo.png',
                width: 350,
              ),
              // Gap(10),
              Lottie.network(
                  "https://lottie.host/469d5741-fdf3-4e4e-831e-705aa5a60064/UgY7rtNzyW.json",
                  height: 170),
            ],
          ),
        ),
      ),
    );
  }
}
