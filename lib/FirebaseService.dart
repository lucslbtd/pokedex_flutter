import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static User? user = FirebaseAuth.instance.currentUser;

  static Future<void> addFavoritePokemon(String pokemonName) async {
    if (user != null) {
      await _db
          .collection('users')
          .doc(user!.uid)
          .collection('favorites')
          .doc(pokemonName)
          .set({'name': pokemonName});
    }
  }

  static Future<void> removeFavoritePokemon(String pokemonName) async {
    if (user != null) {
      await _db
          .collection('users')
          .doc(user!.uid)
          .collection('favorites')
          .doc(pokemonName)
          .delete();
    }
  }

  static Future<List<String>> getFavoritePokemons() async {
    List<String> favorites = [];
    if (user != null) {
      QuerySnapshot snapshot = await _db
          .collection('users')
          .doc(user!.uid)
          .collection('favorites')
          .get();
      for (var doc in snapshot.docs) {
        favorites.add(doc.id);
      }
    }
    return favorites;
  }

  static Future<void> updateFavorites() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot snapshot = await _db
          .collection('users')
          .doc(user!.uid)
          .collection('favorites')
          .get();
    }
  }

  static Future<List<String>> getCreatedPokemons() async {
    List<String> createdPokemons = [];
    if (user != null) {
      QuerySnapshot snapshot = await _db
          .collection('users')
          .doc(user!.uid)
          .collection('mypokes')
          .get();
      for (var doc in snapshot.docs) {
        createdPokemons.add(doc.id);
      }
    }
    return createdPokemons;
  }
}
