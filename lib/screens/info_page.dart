import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/info_complement_page.dart';

class InfoFirstPage extends StatelessWidget {
  const InfoFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          children: [
            imgFirstInfo(),
            textInfoFirstPage(),
            Material(
              elevation: 5.0,
              color: const Color.fromRGBO(23, 62, 165, 1),
              borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InfoSecondPage()),
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

Widget imgFirstInfo() {
  return Expanded(
    flex: 7,
    child: Image.asset('assets/images/info_first.png'),
  );
}

Widget titleInfoFirstPage() {
  return Container(
    width: 250,
    color: Colors.white,
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center, // Align children in the center
      children: [
        Text(
          'Todos os Pokémons em um só Lugar',
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


Widget textInfoFirstPage() {
  return Expanded(
    flex: 3,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, // Align children in the center
      children: [
        titleInfoFirstPage(),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: SizedBox(
            width: 300,
            child: Text(
              'Acesse uma vasta lista de Pokémon de todas as gerações já feitas pela Nintendo',
              textAlign: TextAlign.center, // Set text alignment to center
            ),
          ),
        ),
      ],
    ),
  );
}