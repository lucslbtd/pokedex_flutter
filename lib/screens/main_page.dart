import 'package:flutter/material.dart';
import 'package:pokedex_flutter/screens/favourites_page.dart';
import 'package:pokedex_flutter/screens/pokedex_page.dart';
import 'package:pokedex_flutter/screens/profile_page.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var cor = Colors.blue;
  int currentPageIndex = 0; // Índice da página atual

  // Lista de páginas (conteúdos) que você deseja mostrar ao clicar nos ícones
  final List<Widget> pages = [
    // Substitua esses Widgets pelos seus conteúdos reais
    const PokedexPage(),
    const FavouritesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[
          currentPageIndex], // Mostra a página atual de acordo com o índice
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex, // Define o índice da página atual
        onTap: (index) {
          setState(() {
            currentPageIndex =
                index; // Atualiza o índice da página atual ao clicar
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.catching_pokemon_outlined,
              ),
              label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
        ],
      ),
    );
  }
}
