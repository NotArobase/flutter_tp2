import 'package:flutter/material.dart';
import 'dart:math' as math;

math.Random random = math.Random();

class Tile {
  final String imageURL;
  final String name;
  bool isSelected;
  bool isNeighborSelected;
  Alignment alignment;

  Tile(this.imageURL, this.name,
      {this.isSelected = false,
      this.isNeighborSelected = false,
      Alignment? alignment})
      : alignment = alignment ?? Alignment(0, 0);

  factory Tile.fragImage(int index, int gridColumns, String name) {
    int i = index % gridColumns;
    int j = index ~/ gridColumns;
    int taille = gridColumns;
    return Tile(
      'https://picsum.photos/512',
      name,
      alignment: Alignment(-1.0 + 2.0 * i / (taille - 1),
          -1.0 + 2.0 * j / (taille - 1)),
    );
  }
}

class Exercise7Page extends StatelessWidget {
  const Exercise7Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PositionedTiles(),
    );
  }
}

class TileWidget extends StatelessWidget {
  final Tile tile;
  final int index;
  final int gridColumns;
  final double tileSize;
  final Function(Tile, int) onTap;

  const TileWidget({
    Key? key,
    required this.tile,
    required this.index,
    required this.gridColumns,
    required this.tileSize,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(tile, index);
      },
      child: Container(
        decoration: BoxDecoration(
          border: tile.isNeighborSelected ? Border.all(color: Colors.red, width: 4.0) : null,
        ),
        child: !tile.isSelected
            ? FittedBox(
                fit: BoxFit.fill,
                child: ClipRect(
                  child: Container(
                    child: Align(
                      alignment: tile.alignment,
                      widthFactor: 0.3, // Example values, you may adjust as needed
                      heightFactor: 0.3,
                      child: Image.network(tile.imageURL),
                    ),
                  ),
                ),
              )
            : const Center(
                child: Text(
                  'Empty',
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}


class PositionedTiles extends StatefulWidget {
  const PositionedTiles({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  int gridColumns = 4; // Par défaut
  int selectedIndex = -1;
  late List<Tile> tiles;

  @override
  void initState() {
    super.initState();
    regenerateTiles();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tileSize = screenWidth / gridColumns.toDouble();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeu taquin'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              if (gridColumns > 2) {
                setState(() {
                  gridColumns--;
                  regenerateTiles();
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                gridColumns++;
                regenerateTiles();
                selectedIndex = -1;
              });
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = -1;
            updateTiles();
            _updateNeighborSelection();
          });
        },
        child: GridView.count(
          crossAxisCount: gridColumns,
          children: List.generate(tiles.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: TileWidget(
                tile: tiles[index],
                index: index,
                gridColumns: gridColumns,
                tileSize: tileSize,
                onTap: _handleTileTap,
              ),
            );
          }),
        ),
      ),
    );
  }

  void regenerateTiles() {
    setState(() {
      tiles = List<Tile>.generate(
        gridColumns * gridColumns,
        (index) => Tile.fragImage(index, gridColumns, 'Tile ${index + 1}'),
      );
    });
  }

  void updateTiles() {
    setState(() {
      for (int i = 0; i < tiles.length; i++) {
        tiles[i].isSelected = i == selectedIndex;
      }
    });
  }

  void _handleTileTap(Tile tile, int index) {
    setState(() {
      if (selectedIndex == -1) {
        selectedIndex = index;
        updateTiles();
        _updateNeighborSelection();
      } else {
        if (_isNeighbor(index, selectedIndex)) {
          final Tile tempTile = tiles[selectedIndex];
          tiles[selectedIndex] = tiles[index];
          tiles[index] = tempTile;
          selectedIndex = index;
          _updateNeighborSelection();
          updateTiles();
        }
      }
    });
  }

  void _updateNeighborSelection() {
    if (selectedIndex == -1) {
      for (int i = 0; i < tiles.length; i++) {
        tiles[i].isNeighborSelected = false;
      }
    } else {
      for (int i = 0; i < tiles.length; i++) {
        if (_isNeighbor(i, selectedIndex)) {
          tiles[i].isNeighborSelected = true;
        } else {
          tiles[i].isNeighborSelected = false;
        }
      }
    }
  }

  bool _isNeighbor(int index1, int index2) {
    int row1 = index1 ~/ gridColumns;
    int col1 = index1 % gridColumns;
    int row2 = index2 ~/ gridColumns;
    int col2 = index2 % gridColumns;
    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }
}