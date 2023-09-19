import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/created_pokemons/my_pokemon_page.dart';
import 'package:pokedex_flutter/screens/favorites_pokemon.dart';
import 'package:pokedex_flutter/screens/pokedex/pokedex_screens/pokedex_page.dart';
import 'package:pokedex_flutter/screens/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var cor = Colors.blue;
  int currentPageIndex = 0;

  final List<Widget> pages = [
    const PokedexPage(),
    const FavoritesPageScreen(),
    const ProfilePage(),
    const MyPokemonPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentPageIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.red, // Defina a cor desejada aqui
          ),
          child: BottomNavigationBar(
            currentIndex: currentPageIndex,
            onTap: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            backgroundColor: Colors.red,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.catching_pokemon_outlined,
                  ),
                  label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.archive), label: ''),
            ],
          ),
        ));
  }
}
