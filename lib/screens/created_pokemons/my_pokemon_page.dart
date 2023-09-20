import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/created_pokemons/my_poke_creator.dart';
import 'package:pokedex_flutter/screens/created_pokemons/my_poke_reader.dart';

import '../../FirebaseService.dart';
import 'my_poke_widgets/my_poke_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPokemonPage extends StatefulWidget {
  const MyPokemonPage({super.key});

  @override
  State<MyPokemonPage> createState() => _MyPokemonPageState();
}

class _MyPokemonPageState extends State<MyPokemonPage> {
  static User? user = FirebaseAuth.instance.currentUser;
  List<String> createdPokemonNames = [];
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .collection('mypokes')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      children: snapshot.data!.docs
                          .map((poke) => mypokeCard(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            PokeReaderScreen(poke))));
                              }, poke))
                          .toList(),
                    );
                  }
                  return Text('Nenhum pokemon criado...');
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => PokeEditorScreen())));
        },
        label: Text('Criar Pokemon'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
