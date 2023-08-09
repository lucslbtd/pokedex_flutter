// Arquivo splash_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pokedex_flutter/screens/info_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const InfoFirstPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff173EA5),
      body: Center(
        child: Image.asset('assets/images/splash_screen_logo.png'),
      ),
    );
  }
}
