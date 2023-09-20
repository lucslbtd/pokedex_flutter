import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../pokedex/API/pokeapi.dart';

class PokeEditorScreen extends StatefulWidget {
  const PokeEditorScreen({super.key});

  @override
  State<PokeEditorScreen> createState() => _PokeEditorScreenState();
}

class _PokeEditorScreenState extends State<PokeEditorScreen> {
  User? user;
  TextEditingController _nameController = TextEditingController();
  String? selectedType;
  List<String> pokemonTypes = [];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    PokeAPI.getPokemonTypes().then((types) {
      setState(() {
        pokemonTypes = types;
      });
    }).catchError((error) {
      print('Erro ao carregar os tipos de Pokémon: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0,
        title: Text('Personalize um novo Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 200, // Defina a largura desejada para o campo de texto
                child: TextField(
                  controller: _nameController,
                  maxLength: 15,
                  textAlign:
                      TextAlign.center, // Centralize o texto no campo de texto
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Nomeie o Pokémon',
                  ),
                ),
              ),
            ),
            DropdownButton<String>(
              value: selectedType,
              hint: Text('Escolha o Tipo de Pokémon'),
              items: pokemonTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (user != null) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .collection('mypokes')
                .add({
              'name': _nameController.text,
              'type': selectedType, // Usar o tipo selecionado aqui
            }).then((value) {
              print(value.id);
              Navigator.pop(context);
            }).catchError(
                    (error) => print('Falha ao criar o Pokémon :( $error'));
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
