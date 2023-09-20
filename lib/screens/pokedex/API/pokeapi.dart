import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokeAPI {
  static Future<http.Response> getPokemon() =>
      http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=250"));

  static Future<Map<String, dynamic>> getPokemonDetails(String name) async {
    final response =
        await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$name"));
    return jsonDecode(response.body);
  }

  static Future<List<Map<String, dynamic>>> getPokemonDetailsList(
      List<String> names) async {
    return Future.wait(names.map((name) => getPokemonDetails(name)).toList());
  }

  static Future<List<String>> getPokemonTypes() async {
    final response =
        await http.get(Uri.parse("https://pokeapi.co/api/v2/type"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> types = [];
      for (var type in data['results']) {
        types.add(type['name']);
      }
      return types;
    } else {
      throw Exception('Falha ao carregar os tipos de Pokémon');
    }
  }
}
