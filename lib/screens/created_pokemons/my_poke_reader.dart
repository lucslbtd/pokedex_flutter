import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokeReaderScreen extends StatefulWidget {
  PokeReaderScreen(this.doc, {Key? key}) : super(key: key);
  final QueryDocumentSnapshot doc;

  @override
  _PokeReaderScreenState createState() => _PokeReaderScreenState();
}

class _PokeReaderScreenState extends State<PokeReaderScreen> {
  static User? user = FirebaseAuth.instance.currentUser;
  TextEditingController _nameController = TextEditingController();
  String? _selectedType;
  List<String> _pokemonTypes = [];
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.doc['name'];
    _selectedType = widget.doc['type'];
    loadPokemonTypes(); // Carregar os tipos de Pokémon ao inicializar
  }

  // Função para carregar os tipos de Pokémon da PokeAPI
  void loadPokemonTypes() async {
    try {
      // Substitua a URL pela URL correta da PokeAPI se necessário
      final response =
          await http.get(Uri.parse('https://pokeapi.co/api/v2/type'));
      final data = json.decode(response.body);
      final types = (data['results'] as List)
          .map((type) => type['name'] as String)
          .toList();
      setState(() {
        _pokemonTypes = types;
      });
    } catch (error) {
      print('Erro ao carregar os tipos de Pokémon: $error');
    }
  }

  void _updatePokemon() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('mypokes')
          .doc(widget.doc.id)
          .update({
        'name': _nameController.text,
        'type': _selectedType,
      });
      Navigator.pop(context);
    } catch (error) {
      print('Falha ao editar o pokemon :( $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: isEditing
            ? TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                textAlign: TextAlign.center,
              )
            : Text('${_nameController.text}', textAlign: TextAlign.center),
        backgroundColor: Colors.redAccent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isEditing
                ? DropdownButtonFormField<String>(
                    value: _selectedType,
                    items: _pokemonTypes.map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value;
                      });
                    },
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tipo: $_selectedType',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isEditing ? null : _updatePokemon,
        child: Icon(Icons.save),
      ),
    );
  }
}
