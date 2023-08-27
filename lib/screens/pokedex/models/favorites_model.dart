import 'package:flutter/material.dart';

import '../widgets/pokemon_card.dart';

class Favorites extends ChangeNotifier {
  final List<PokemonCard> _pokemonsFavoritos = [];
  List<PokemonCard> get favList => _pokemonsFavoritos;

  void add(PokemonCard pokemon) {
    _pokemonsFavoritos.add(pokemon);
    notifyListeners();
  }

  void remove(PokemonCard pokemon) {
    _pokemonsFavoritos.remove(pokemon);
    notifyListeners();
  }
}
