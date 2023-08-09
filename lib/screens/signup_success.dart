import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/main_page.dart';

class SignupSuccess extends StatelessWidget {
  const SignupSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          children: [
            imgLoginSuccess(),
            textSignupSuccess(),
            Material(
              elevation: 5.0,
              color: const Color.fromRGBO(23, 62, 165, 1),
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                },
                minWidth: 200.0,
                height: 42.0,
                child: const Text(
                  'Continuar',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        )));
  }
}

Widget imgLoginSuccess() {
  return Expanded(
    flex: 7,
    child: Image.asset('assets/images/signup_success.png'),
  );
}

Widget titleSignupSuccess() {
  return Container(
    width: 250,
    color: Colors.white,
    child: const Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // Align children in the center
      children: [
        Text(
          'Sua conta foi criada com sucesso!',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.black,
          ),
          textAlign: TextAlign.center, // Set text alignment to center
        ),
      ],
    ),
  );
}

Widget textSignupSuccess() {
  return Expanded(
    flex: 3,
    child: Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // Align children in the center
      children: [
        titleSignupSuccess(),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: SizedBox(
            width: 300,
            child: Text(
              'Seja bem-vindo, treinador! Estamos animados para acompanhar sua jornada.',
              textAlign: TextAlign.center, // Set text alignment to center
            ),
          ),
        ),
      ],
    ),
  );
}
