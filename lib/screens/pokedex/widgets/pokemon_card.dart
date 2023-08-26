import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/pokedex/pokedex_screens/pokemons_details_page.dart';
import 'package:provider/provider.dart';
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
    return Card(
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
          padding: const EdgeInsets.all(10.0),
          height: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nº ${widget.id}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(widget.image),
                    IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red : Colors.grey,
                      ),
                      onPressed: toggleFavorite,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
