import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pokedex/API/pokeapi.dart';
import 'my_poke_widgets/my_poke_card.dart';
import 'package:pokedex_flutter/screens/created_pokemons/my_poke_creator.dart';
import 'package:pokedex_flutter/screens/created_pokemons/my_poke_reader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyPokemonPage extends StatefulWidget {
  const MyPokemonPage({Key? key}) : super(key: key);

  @override
  _MyPokemonPageState createState() => _MyPokemonPageState();
}

class _MyPokemonPageState extends State<MyPokemonPage> {
  User? user;
  TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot<Object?>> originalPokemonList = [];
  List<QueryDocumentSnapshot<Object?>> displayedPokemonList = [];
  bool isSearching = false;
  String? selectedType;
  List<String> pokemonTypes = [];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;

    // Carregue a lista original de Pokémon no initState
    loadOriginalPokemonList();
    // Carregue os tipos de Pokémon da PokeAPI
    loadPokemonTypes();
  }

  // Função para carregar a lista original de Pokémon do Firebase Firestore
  void loadOriginalPokemonList() {
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('mypokes')
          .get()
          .then((querySnapshot) {
        setState(() {
          originalPokemonList = querySnapshot.docs;
          displayedPokemonList = originalPokemonList;
        });
      });
    }
  }

  // Função para carregar os tipos de Pokémon da PokeAPI
  void loadPokemonTypes() async {
    try {
      final response =
          await http.get(Uri.parse('https://pokeapi.co/api/v2/type'));
      final data = json.decode(response.body);
      final types = (data['results'] as List)
          .map((type) => type['name'] as String)
          .toList();
      setState(() {
        pokemonTypes = types;
      });
    } catch (error) {
      print('Erro ao carregar os tipos de Pokémon: $error');
    }
  }

  void filterPokemon(String query) {
    setState(() {
      // Filtrar os Pokémon com base no nome/título
      final filteredByName = originalPokemonList.where((poke) {
        final name = poke['name'].toString().toLowerCase();
        final queryLower = query.toLowerCase();
        return name.contains(queryLower);
      }).toList();

      // Filtrar os Pokémon com base no tipo selecionado
      final filteredByType = originalPokemonList.where((poke) {
        final type = poke['type'].toString().toLowerCase();
        return type.contains(selectedType?.toLowerCase() ?? '');
      }).toList();

      // Verificar se há texto na barra de pesquisa e um tipo selecionado
      if (query.isNotEmpty && selectedType != null) {
        displayedPokemonList = filteredByName.where((poke) {
          final type = poke['type'].toString().toLowerCase();
          return type.contains(selectedType!.toLowerCase());
        }).toList();
        isSearching = true;
      }
      // Se apenas o tipo estiver selecionado
      else if (selectedType != null) {
        displayedPokemonList = filteredByType;
        isSearching = true;
      }
      // Se apenas a barra de pesquisa tiver texto
      else if (query.isNotEmpty) {
        displayedPokemonList = filteredByName;
        isSearching = true;
      }
      // Se nada for selecionado, mostre todos os Pokémon novamente
      else {
        displayedPokemonList = originalPokemonList;
        isSearching = false;
      }
    });
  }

  // Função para recarregar a lista de Pokémon após a exclusão
  void reloadPokemonList() {
    loadOriginalPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokemons Personalizados',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) => filterPokemon(query),
              decoration: InputDecoration(
                labelText: 'Pesquisar Pokémon...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedType,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                hint: Text('Filtrar por Tipo de Pokémon'),
                items: [
                  DropdownMenuItem<String>(
                    value: null, // Valor nulo para remover o filtro por tipo
                    child: Text('Sem Filtro de Tipo'),
                  ),
                  ...pokemonTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedType = value;

                    // Reaplicar a filtragem com base no tipo selecionado e no texto da barra de pesquisa
                    filterPokemon(_searchController.text);
                  });
                },
              ),
            ),
          ),
          // Verificar se displayedPokemonList está vazio
          displayedPokemonList.isEmpty
              ? Center(
                  child: Text(
                    'Nenhum pokemon criado...',
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                    ),
                    itemCount: displayedPokemonList.length,
                    itemBuilder: (context, index) {
                      final poke = displayedPokemonList[index];
                      return mypokeCard(
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => PokeReaderScreen(poke)),
                              ),
                            ).then((value) {
                              // Após a leitura, recarregue a lista de Pokémon
                              reloadPokemonList();
                            });
                          },
                          poke,
                          () {
                            // Esta função de retorno de chamada é chamada após a exclusão
                            reloadPokemonList();
                          });
                    },
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => PokeEditorScreen()),
            ),
          ).then((value) {
            // Após criar um novo Pokémon, atualize a lista de Pokémon exibidos
            reloadPokemonList();
          });
        },
        label: Text('Criar Pokémon'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
