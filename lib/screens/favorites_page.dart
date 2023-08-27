import 'package:flutter/material.dart';
import 'pokedex/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';
import '../screens/pokedex/models/favorites_model.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favoritos',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white, // Set background color to white
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FavPageMode(),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoritesText extends StatelessWidget {
  const FavoritesText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 16),
        Text(
          'Você não favoritou nenhum Pokémon :(',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          'Clique no ícone de coração dos seus pokémons favoritos e eles aparecerão aqui.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class FavPageMode extends StatefulWidget {
  const FavPageMode({super.key});

  @override
  State<FavPageMode> createState() => _FavPageModeState();
}

class _FavPageModeState extends State<FavPageMode> {
  @override
  Widget build(BuildContext context) {
    var favoritePokemons = Provider.of<Favorites>(context);
    if (favoritePokemons.favList.length == 0) {
      return FavoritesText();
    } else {
      return CardFavorito();
    }
  }
}

class CardFavorito extends StatefulWidget {
  const CardFavorito({super.key});

  @override
  State<CardFavorito> createState() => _CardFavoritoState();
}

class _CardFavoritoState extends State<CardFavorito> {
  @override
  Widget build(BuildContext context) {
    var favoritePokemons = Provider.of<Favorites>(context);
    final width = MediaQuery.of(context).size.width;
    const crossAxisCount = 1;
    final aspectRatio = width / 200;

    return Expanded(
      child: Consumer<Favorites>(
        builder: (context, value, child) {
          return GridView.builder(
            padding: const EdgeInsets.all(7),
            itemCount: value.favList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: aspectRatio,
            ),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final pokemonCard = favoritePokemons.favList[index];
              return pokemonCard;
            },
          );
        },
      ),
    );
  }
}
