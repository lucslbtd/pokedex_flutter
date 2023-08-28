import 'package:flutter/material.dart';

class PokemonCardData extends StatelessWidget {
  final String image;
  final String name;

  const PokemonCardData({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${name[0].toUpperCase()}${name.substring(1)}",
              style: const TextStyle(
                fontSize: 21,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Image.network(
            image,
            width: 80,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
