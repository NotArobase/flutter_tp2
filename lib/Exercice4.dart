import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.network(imageURL),
          ),
        ),
      ),
    );
  }
}

Tile tile = Tile(
    imageURL: 'https://picsum.photos/512', alignment: const Alignment(0, 0));

class Exercise4Page extends StatelessWidget {
  const Exercise4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recadrage de l\'image'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(children: [
        SizedBox(
            width: 150.0,
            height: 150.0,
            child: Container(
                margin: const EdgeInsets.all(20.0),
                child: createTileWidgetFrom(tile))),
        Container(
            height: 200,
            child: Image.network('https://picsum.photos/512',
                fit: BoxFit.cover))
      ])),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tape sur tile");
      },
    );
  }
}