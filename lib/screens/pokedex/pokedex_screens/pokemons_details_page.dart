import 'package:flutter/material.dart';
import '../API/pokeapi.dart';

List<PokemonNote> listNotes = [];

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

  var color = Colors.amber;

  changeColor() {
    setState(() {
      color = Colors.blue;
    });
  }

  addNote() {
    TextEditingController controller = TextEditingController();
    setState(() {
      listNotes.add(PokemonNote(controller: controller));
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
                      return Dismissible(
                        key: Key(listNotes[index].hashCode.toString()),
                        onDismissed: (direction) {
                          setState(() {
                            listNotes.removeAt(index);
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: listNotes[index],
                      );
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
  final TextEditingController controller;
  const PokemonNote({Key? key, required this.controller}) : super(key: key);

  @override
  State<PokemonNote> createState() => _PokemonNoteState();
}

class _PokemonNoteState extends State<PokemonNote> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Digite um título',
            border: InputBorder.none,
          ),
        ),
        initiallyExpanded: false,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Escreva uma anotação...',
              border: InputBorder.none,
            ),
            maxLines: 15,
            keyboardType: TextInputType.multiline,
            controller: widget.controller,
          )
        ],
      ),
    );
  }
}
