import 'dart:convert';
import 'package:flutter/material.dart';
import '../API/pokeapi.dart';
import '../models/poke_model.dart';
import '../widgets/pokemon_grid.dart';
import 'package:string_similarity/string_similarity.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  List<Pokemon> pokemon = List.empty();
  List<Pokemon> filteredItems = [];

  @override
  void initState() {
    super.initState();
    getPokemonFromPokeApi();
  }

  void filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = pokemon;
      } else {
        filteredItems = pokemon
            .where((item) => _calculateSimilarity(item.name, query) >= 0.4)
            .toList();
      }
    });
  }

  double _calculateSimilarity(String itemName, String query) {
    final double similarity = itemName.similarityTo(query);
    return similarity;
  }

  void getPokemonFromPokeApi() async {
    PokeAPI.getPokemon().then((response) {
      List<Map<String, dynamic>> data =
          List.from(json.decode(response.body)['results']);
      setState(() {
        pokemon = data.asMap().entries.map<Pokemon>((element) {
          element.value['id'] = element.key + 1;
          element.value['img'] =
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element.key + 1}.png";
          return Pokemon.fromJson(element.value);
        }).toList();
      });
      filteredItems =
          pokemon; // Define os itens filtrados inicialmente como todos os Pokémon
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged:
                  filterItems, // Chama a função de filtro a cada alteração no texto
              decoration: InputDecoration(
                labelText: 'Procurar Pokémon...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  // Borda do campo
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: (filteredItems.isEmpty)
                ? PokemonGrid(pokemon: pokemon)
                : PokemonGrid(pokemon: filteredItems),
          ),
        ],
      ),
    );
  }
}
