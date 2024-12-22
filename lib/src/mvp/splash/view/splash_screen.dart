import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_trainings_app/src/widget/widget.dart';
import 'package:my_trainings_app/utilities/utilities.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    initializeSettings();
  }

  /// Start Timer...
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      timer.cancel();

      Navigator.pushReplacementNamed(context, RouteUtilities.trainingScreen);
    });
  }

  /// initialize the settings.
  Future<void> initializeSettings() async {
    /// initialize the theme.
    ThemeManager.initializeTheme(context);

    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VariableUtilities.screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: VariableUtilities.theme.whiteColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageView(imageUrl: AssetUtilities.appLogo),
        ],
      )),
    );
  }
}
