// main.dart
import 'package:apps/ui/onBoarding/onBoardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
        primaryColor: Colors.green,
        brightness: Brightness.light,
        textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.black),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          color: Colors.transparent,
          elevation: 0,
          actionsIconTheme: IconThemeData(color: Colors.green),
          iconTheme: IconThemeData(color: Colors.green),
        ),
      ),
      color: Colors.green,
      home: OnBoarding(),
    );
  }
}

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() {
    return OnBoardingState();
  }
}

class OnBoardingState extends State<OnBoarding> {
  Future<void> hasFinishedOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool finishedOnBoarding = prefs.getBool(HAS_FINISHED_ONBOARDING) ?? false;
    print("¿Ha finalizado el onboarding? $finishedOnBoarding");

    if (true) {
      print("Navegando a la pantalla de onboarding");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    hasFinishedOnBoarding();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
