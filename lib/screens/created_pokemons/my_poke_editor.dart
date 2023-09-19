import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class PokeEditorScreen extends StatefulWidget {
  const PokeEditorScreen({super.key});

  @override
  State<PokeEditorScreen> createState() => _PokeEditorScreenState();
}

class _PokeEditorScreenState extends State<PokeEditorScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        title: Text('Personalize um novo pokemon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: _titleController,
            maxLength: 15,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Nomeie o Pokemon'),
          ),
          TextField(
            controller: _mainController,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: 'Blabla'),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            FirebaseFirestore.instance.collection('MyPokemons').add({
              'name': _titleController.text,
              'id': '2',
              'type': _mainController.text,
            }).then((value) {
              print(value.id);
              Navigator.pop(context);
            }).catchError(
                (error) => print('Falha ao criar o pokemon :( $error'));
          },
          child: Icon(Icons.save)),
    );
  }
}
