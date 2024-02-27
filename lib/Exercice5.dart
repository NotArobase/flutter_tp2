import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

  List<Widget> croppedImageTiles(int taille) {
    // Split image into a grid of size taille x taille
    List<Widget> tiles = [];
    double tileSize = 1.0 / taille;
    for (int i = 0; i < taille; i++) {
      for (int j = 0; j < taille; j++) {
        tiles.add(
          FittedBox(
            fit: BoxFit.fill,
            child: ClipRect(
              child: Container(
                child: Align(
                  alignment: Alignment(-1.0 + 2.0 * j / (taille - 1), -1.0 + 2.0 * i / (taille - 1)),
                  widthFactor: tileSize,
                  heightFactor: tileSize,
                  child: Image.network(
                    this.imageURL,
                    alignment: this.alignment,
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }
    return tiles;
  }
}

final List<Tile> tiles = [
  Tile(
    imageURL: 'https://picsum.photos/512',
    alignment: Alignment(0, 0),
  )
];

class Exercise5Page extends StatefulWidget {
  @override
  _Exercise5PageState createState() => _Exercise5PageState();
}

class _Exercise5PageState extends State<Exercise5Page> {
  int _taille = 5;

  @override
  Widget build(BuildContext context) {
    double spacingFactor = 1.0 / _taille; // Calculate spacing factor

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50), // Adjust this value as needed
            child: GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 20 * spacingFactor, // Adjust cross axis spacing
              mainAxisSpacing: 20 * spacingFactor, // Adjust main axis spacing
              crossAxisCount: _taille,
              children: tiles
                  .expand((tile) => tile.croppedImageTiles(_taille))
                  .map((croppedTile) => Container(
                        padding: const EdgeInsets.all(0),
                        color: Colors.teal[100],
                        child: croppedTile,
                      ))
                  .toList(),
            ),
          ),
          Slider(
            value: _taille.toDouble(),
            min: 2,
            max: 15,
            divisions: 15-2,
            label: _taille.toString(),
            onChanged: (double value) {
              setState(() {
                _taille = value.toInt();
              });
            },
          ),
        ],
      ),
    );
  }
}