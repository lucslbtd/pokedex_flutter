import 'package:flutter/material.dart';
import '../API/pokeapi.dart';

class PokemonDetailsPage extends StatefulWidget {
  final int id;
  final String name;
  final String image;

  const PokemonDetailsPage(
      {required this.id, required this.name, required this.image});

  @override
  _PokemonDetailsPageState createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  late Future<Map<String, dynamic>> pokemonDetails;

  List<PokemonNote> listNotes = [];

  var color = Colors.amber;

  changeColor() {
    setState(() {
      color = Colors.blue;
    });
  }

  addNote() {
    setState(() {
      listNotes.add(const PokemonNote());
    });
  }

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
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(widget.image),
                  Text('Nome: ${widget.name}'),
                  Text('ID: ${widget.id}'),
                  Text('Tipo: $type'),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: listNotes.length,
                    itemBuilder: (context, index) {
                      return listNotes[index];
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote();
        },
        child: const Icon(Icons.note_add_outlined),
      ),
    );
  }
}

class PokemonNote extends StatefulWidget {
  const PokemonNote({super.key});

  @override
  State<PokemonNote> createState() => _PokemonNoteState();
}

class _PokemonNoteState extends State<PokemonNote> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Colors.black,
      child: ListTile(
        title: Text('Card Title'),
        subtitle: Text('Card Subtitle'),
      ),
    );
  }
}
