import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class PokeEditorScreen extends StatefulWidget {
  const PokeEditorScreen({super.key});

  @override
  State<PokeEditorScreen> createState() => _PokeEditorScreenState();
}

class _PokeEditorScreenState extends State<PokeEditorScreen> {
  static User? user = FirebaseAuth.instance.currentUser;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
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
            controller: _nameController,
            maxLength: 15,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Nomeie o Pokemon'),
          ),
          TextField(
            controller: _typeController,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: 'Blabla'),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .collection('mypokes')
                .add({
              'name': _nameController.text,
              'type': _typeController.text,
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
