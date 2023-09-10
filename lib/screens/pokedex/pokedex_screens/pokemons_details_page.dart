import 'package:flutter/material.dart';
import '../API/pokeapi.dart';

Map<String, List<PokemonNote>> pokemonNotesMap = {};

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
    TextEditingController titleController = TextEditingController();
    TextEditingController textController = TextEditingController();
    setState(() {
      if (!pokemonNotesMap.containsKey(widget.name)) {
        pokemonNotesMap[widget.name] = [];
      }
      pokemonNotesMap[widget.name]!.add(PokemonNote(
        titleController: titleController,
        textController: textController,
      ));
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
                    itemCount: pokemonNotesMap.containsKey(widget.name)
                        ? pokemonNotesMap[widget.name]!.length
                        : 0,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(pokemonNotesMap[widget.name]![index]
                            .hashCode
                            .toString()),
                        onDismissed: (direction) {
                          setState(() {
                            pokemonNotesMap[widget.name]!.removeAt(index);
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
                        child: pokemonNotesMap[widget.name]![index],
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
  final TextEditingController titleController;
  final TextEditingController textController;
  const PokemonNote(
      {Key? key, required this.titleController, required this.textController})
      : super(key: key);

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
          controller:
              widget.titleController, // Associar o controlador ao título
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
            controller:
                widget.textController, // Associar o controlador ao texto
          )
        ],
      ),
    );
  }
}
