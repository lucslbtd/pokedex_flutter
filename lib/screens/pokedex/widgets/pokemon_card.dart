import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/pokedex/pokedex_screens/pokemons_details_page.dart';

import 'pokemon_card_background.dart';
import 'pokemon_card_data.dart';

class PokemonCard extends StatefulWidget {
  final int id;
  final String name;
  final String image;
  const PokemonCard(
      {super.key, required this.id, required this.name, required this.image});

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  bool isFavorited = false;

  void toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokemonDetailsPage(
                      id: widget.id,
                      name: widget.name,
                      image: widget.image,
                    ),
                  ),
                );
              },
              child: Container(
                height: 300,
                //padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nº ${widget.id}',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.grey),
                            ), // Mostra o ID
                            Text(
                              '${widget.name}',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: Colors.black),
                            )
                          ]),
                    ), // Mostra o nome
                    Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(widget.image), // Mostra a imagem
                          Container(
                            child: IconButton(
                              icon: Icon(
                                isFavorited
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorited ? Colors.red : Colors.grey,
                              ),
                              onPressed: toggleFavorite,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
