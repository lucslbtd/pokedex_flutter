import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

Widget mypokeCard(Function()? onTap, QueryDocumentSnapshot doc) {
  User? user = FirebaseAuth.instance.currentUser;
  return Card(
    child: ListTile(
      leading: Icon(Icons.catching_pokemon_outlined),
      title: Text(doc['name']),
      subtitle: Text(doc['type']),
      onTap: onTap,
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          final docPoke = FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .collection('mypokes')
              .doc(doc.id);
          docPoke.delete();
        },
      ),
    ),
  );
}
