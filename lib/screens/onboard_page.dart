import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/login_page.dart';
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
              style: TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 8),
            const Text(
              'Basta criar uma conta e começar a explorar o mundo Pokémon hoje!',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 24),
            Material(
              elevation: 5.0,
              color: const Color.fromARGB(255, 0, 26, 255),
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                minWidth: 200.0,
                height: 42.0,
                child: const Text(
                  'Criar conta',
                  style: TextStyle(
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
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 26, 255),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
