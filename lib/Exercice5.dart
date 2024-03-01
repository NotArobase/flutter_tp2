import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

  List<Widget> croppedImageTiles(int taille) {
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
                    imageURL,
                    alignment: alignment,
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
    alignment: const Alignment(0, 0),
  )
];

class Exercise5Page extends StatefulWidget {
  const Exercise5Page({super.key});

  @override
  _Exercise5PageState createState() => _Exercise5PageState();
}

class _Exercise5PageState extends State<Exercise5Page> {
  int _taille = 5;

  @override
  Widget build(BuildContext context) {
    double spacingFactor = 1.0 / _taille;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  "Vue mosaïque",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 20 * spacingFactor,
              mainAxisSpacing: 20 * spacingFactor,
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
            divisions: 15 - 2,
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
