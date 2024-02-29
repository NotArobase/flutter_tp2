import 'package:flutter/material.dart';
import 'dart:math' as math;

math.Random random = new math.Random();

class Tile {
  final String imageURL;
  final String name;
  bool isSelected;
  bool isNeighborSelected;

  Tile(this.imageURL, this.name, {this.isSelected = false, this.isNeighborSelected = false});

  factory Tile.fragImage(int index, String name) {
    return Tile(
      'https://picsum.photos/512',
      name,
    );
  }

  String _getTileName() {
    return this.isSelected ? "Empty" : this.name;
  }
}

class Exercise7Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  TileWidget({
    required this.tile,
    required this.index,
    required this.gridColumns,
    required this.tileSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    int row = index ~/ gridColumns;
    int col = index % gridColumns;

    double alignmentX = col * (1 / (gridColumns - 1));
    double alignmentY = row * (1 / (gridColumns - 1));

    return GestureDetector(
      onTap: () {
        onTap(tile, index);
      },
      child: Container(
        decoration: BoxDecoration(
          border: tile.isNeighborSelected ? Border.all(color: Colors.red, width: 4.0) : null,
        ),
        child: !tile.isSelected
            ? Image.network(
                tile.imageURL,
                alignment: Alignment(-1.0 + 2.0 * alignmentX, -1.0 + 2.0 * alignmentY),
                width: tileSize,
                height: tileSize,
                fit: BoxFit.cover,
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
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  int gridColumns = 4; // Default number of columns
  int selectedIndex = -1;
  List<Tile> tiles = List<Tile>.generate(
    16,
    (index) => Tile.fragImage(index, 'Tile ${index + 1}'),
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tileSize = screenWidth / gridColumns.toDouble();

    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu taquin'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (gridColumns > 2) {
                  gridColumns--;
                  regenerateTiles();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                gridColumns++;
                regenerateTiles();
                setState(() {
                  selectedIndex = -1;
                });
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
              padding: EdgeInsets.all(5.0),
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
        (index) => Tile.fragImage(index, 'Tile ${index + 1}'),
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