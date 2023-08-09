import 'package:flutter/material.dart';

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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FavoritesText(),
          ],
        ),
      ),
    );
  }
}


class FavoritesText extends StatelessWidget {
  const FavoritesText({super.key});

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
