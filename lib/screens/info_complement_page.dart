import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/onboard_page.dart';

class InfoSecondPage extends StatelessWidget {
  const InfoSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          children: [
            imgSecondInfo(),
            textInfoSecondPage(),
            Material(
              elevation: 5.0,
              color: const Color.fromRGBO(23, 62, 165, 1),
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OnboardPage()),
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

Widget imgSecondInfo() {
  return Expanded(
    flex: 7,
    child: Image.asset('assets/images/info_second.png'),
  );
}

Widget titleInfoSecondPage() {
  return Container(
    width: 250,
    color: Colors.white,
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center, // Align children in the center
      children: [
        Text(
          'Mantenha sua Pokédex atualizada',
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


Widget textInfoSecondPage() {
  return Expanded(
    flex: 3,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, // Align children in the center
      children: [
        titleInfoSecondPage(),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: SizedBox(
            width: 300,
            child: Text(
              'Cadastre-se e mantenha seu perfil, pokémon favoritos, configurações e muito mais, salvos no aplicativo, mesmo sem conexão com a internet.',
              textAlign: TextAlign.center, // Set text alignment to center
            ),
          ),
        ),
      ],
    ),
  );
}