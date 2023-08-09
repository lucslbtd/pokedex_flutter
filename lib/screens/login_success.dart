import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/main_page.dart';

class LoginSuccess extends StatelessWidget {
  const LoginSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          children: [
            imgLoginSuccess(),
            textoLoginSuccess(),
            Material(
              elevation: 5.0,
              color: const Color.fromARGB(255, 0, 26, 255),
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
                  style: TextStyle(color: Colors.white),
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
    child: Image.asset('assets/images/login_sucesso_img.png'),
  );
}

Widget titleLoginSuccess() {
  return Container(
      width: 250,
      color: Colors.white,
      child: const Center(
        child: Column(children: [
          Text(
            'Bem vindo de volta,',
            style: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.black),
          ),
          Text(
            'Treinador!',
            style: TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.black),
          ),
        ]),
      ));
}

Widget textoLoginSuccess() {
  return Expanded(
    flex: 3,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, // Align children in the center
      children: [
        titleLoginSuccess(),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: SizedBox(
            width: 300,
            child: Text(
              'Esperamos que tenha tido uma longa jornada desde a última vez em que nos visitou.',
              textAlign: TextAlign.center, // Set text alignment to center
            ),
          ),
        ),
      ],
    ),
  );
}
