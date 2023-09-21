import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

import "my_poke_img.dart";

// Defina uma função de retorno de chamada onDelete
typedef void OnDelete();

Widget mypokeCard(
    Function()? onTap, QueryDocumentSnapshot doc, OnDelete onDelete) {
  User? user = FirebaseAuth.instance.currentUser;
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.catching_pokemon_outlined),
              title: Text(doc['name']),
              subtitle: Text(doc['type']),
              onTap: onTap,
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  if (user != null) {
                    final docPoke = FirebaseFirestore.instance
                        .collection('users')
                        .doc(user!.uid)
                        .collection('mypokes')
                        .doc(doc.id);
                    await docPoke.delete();
                    onDelete(); // Chame a função de retorno de chamada após a exclusão
                  }
                },
              ),
            ),
            ImageDisplay(doc['img'])
          ],
        ),
      ),
    ),
  );
}
