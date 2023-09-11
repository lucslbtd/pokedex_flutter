import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/pokedex/widgets/pokemon_card.dart';
import '../screens/pokedex/API/pokeapi.dart';
import '../FirebaseService.dart';

class FavoritesPageScreen extends StatefulWidget {
  const FavoritesPageScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FavoritesPageScreenState createState() => _FavoritesPageScreenState();
}

class _FavoritesPageScreenState extends State<FavoritesPageScreen> {
  List<String> favoritePokemonNames = [];

  @override
  void initState() {
    super.initState();
    FirebaseService.getFavoritePokemons().then((favorites) {
      setState(() {
        favoritePokemonNames = favorites;
      });
    });
  }

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
      body: favoritePokemonNames.isEmpty
          ? const FavoritesText()
          : FutureBuilder(
              future: PokeAPI.getPokemonDetailsList(favoritePokemonNames),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Erro ao carregar detalhes');
                } else {
                  List<Map<String, dynamic>>? details = snapshot.data;

                  details?.sort((a, b) => a['id'].compareTo(b['id']));

                  return GridView.builder(
                    padding: const EdgeInsets.all(7),
                    itemCount: details?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      String name = details?[index]['name'];
                      int id = details?[index]['id'];
                      String imageUrl =
                          details?[index]['sprites']['front_default'];
                      return PokemonCard(id: id, name: name, image: imageUrl);
                    },
                  );
                }
              },
            ),
    );
  }
}

class FavoritesText extends StatelessWidget {
  const FavoritesText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
