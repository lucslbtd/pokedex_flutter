import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

Widget mypokeCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return Card(
    child: ListTile(
      leading: Icon(Icons.catching_pokemon_outlined),
      title: Text(doc['name']),
      subtitle: Text(doc['type']),
      onTap: onTap,
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          final docPoke =
              FirebaseFirestore.instance.collection('MyPokemons').doc(doc.id);
          docPoke.delete();
        },
      ),
    ),
  );
}
