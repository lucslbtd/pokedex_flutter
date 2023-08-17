import 'package:flutter/material.dart';
import '../API/pokeapi.dart';

class PokemonDetailsPage extends StatefulWidget {
  final int id;
  final String name;
  final String image;

  const PokemonDetailsPage(
      {required this.id, required this.name, required this.image});

  @override
  // ignore: library_private_types_in_public_api
  _PokemonDetailsPageState createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  late Future<Map<String, dynamic>> pokemonDetails;

  @override
  void initState() {
    super.initState();
    pokemonDetails = PokeAPI.getPokemonDetails(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Pokémon'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: pokemonDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else {
            var types = snapshot.data?['types'] as List;
            String type = types[0]['type']['name'];
            return Column(
              children: [
                Image.network(widget.image),
                Text('Nome: ${widget.name}'),
                Text('ID: ${widget.id}'),
                Text('Tipo: $type'),
              ],
            );
          }
        },
      ),
    );
  }
}
