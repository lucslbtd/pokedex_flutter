import 'package:flutter/material.dart';

import '../widgets/pokemon_card.dart';

class Favorites extends ChangeNotifier {
  final List<int> _idFavoritos = [];
  List<int> get favIdList => _idFavoritos;
  final List<PokemonCard> _pokemonsFavoritos = [];
  List<PokemonCard> get favList => _pokemonsFavoritos;

  void addID(int id) {
    _idFavoritos.add(id);
    notifyListeners();
  }

  void removeID(int id) {
    _idFavoritos.remove(id);
    notifyListeners();
  }

  void add(PokemonCard pokemon) {
    _pokemonsFavoritos.add(pokemon);
    notifyListeners();
  }

  void remove(PokemonCard pokemon) {
    _pokemonsFavoritos.remove(pokemon);
    notifyListeners();
  }
}
