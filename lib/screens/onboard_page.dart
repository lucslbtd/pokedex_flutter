import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/sign_up_email.dart';
import 'package:pokedex_flutter/screens/login_01.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/onboard_image.png'),
            const SizedBox(height: 16),
            const Text(
              'Está pronto para essa aventura?',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 26),
            ),
            const SizedBox(height: 8),
            const Text(
              'Basta criar uma conta e começar a explorar o mundo Pokémon hoje!',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
            ),
            const SizedBox(height: 24),
            Material(
              elevation: 5.0,
              color: const Color.fromRGBO(23, 62, 165, 1),
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                minWidth: 200.0,
                height: 42.0,
                child: const Text(
                  'Criar conta',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login01()),
                );
              },
              child: const Text(
                'Já tenho uma conta',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Color.fromRGBO(23, 62, 165, 1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
