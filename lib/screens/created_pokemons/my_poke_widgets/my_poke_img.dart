import "package:flutter/material.dart";

class ImageDisplay extends StatelessWidget {
  final String imageUrl;

  ImageDisplay(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              child: imageUrl.isEmpty
                  ? Text('Nenhuma URL de imagem fornecida.')
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
