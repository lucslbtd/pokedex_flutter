import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/pokedex/pokedex_screens/pokemons_details_page.dart';

import 'pokemon_card_background.dart';
import 'pokemon_card_data.dart';

class PokemonCard extends StatelessWidget {
  final int id;
  final String name;
  final String image;

  const PokemonCard({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
  }) : super(key: key);

  BoxDecoration getContainerDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.withOpacity(0.24),
          width: 1,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        enableFeedback: true,
        splashColor: Colors.red[50],
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PokemonDetailsPage(id: id, name: name, image: image),
            ),
          )
        },
        child: Container(
          width: double.infinity, // Ocupar a largura completa
          height: 120, // Ajuste a altura conforme necessário
          padding: const EdgeInsets.all(7),
          decoration: getContainerDecoration(),
          child: Stack(
            children: [
              PokemonCardBackground(id: id),
              PokemonCardData(name: name, image: image),
            ],
          ),
        ),
      ),
    );
  }
}
