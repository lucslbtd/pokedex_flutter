import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pokedex_flutter/screens/login_success.dart';

class LoadLoginScreen extends StatefulWidget {
  const LoadLoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadLoginScreenState createState() => _LoadLoginScreenState();
}

class _LoadLoginScreenState extends State<LoadLoginScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginSuccess(),
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
