import 'package:flutter/material.dart';
import 'dart:math' as math;

math.Random random = new math.Random();

class Tile {
  final Color color;
  final String name;
  bool isSelected;
  bool isNeighborSelected;

  Tile(this.color, this.name, {this.isSelected = false, this.isNeighborSelected = false});

  factory Tile.randomColor(String name) {
    return Tile(
        Color.fromARGB(
            255, random.nextInt(255), random.nextInt(255), random.nextInt(255)),
        name);
  }

  Color _getColor() {
    
      return this.isSelected ? Colors.white : this.color;
  }

  String _getTileName() {
    
      return this.isSelected ?"Empty" : this.name  ;
  }

  Color _getTileNameColor() {
    
      return this.isSelected ? Colors.black : Colors.white;
  }
}

class Exercise6Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PositionedTiles(),
    );
  }
}

class TileWidget extends StatefulWidget {
  final Tile tile;
  final int index;
  final Function(Tile, int) onTap;

  TileWidget({required this.tile, required this.index, required this.onTap});

  @override
  _TileWidgetState createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.tile, widget.index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.tile._getColor(),
          border: widget.tile.isNeighborSelected ? Border.all(color: Colors.red, width: 4.0) : null,
        ),
        child: Center(
          child: Text(
            widget.tile._getTileName(),
            style: TextStyle(color: widget.tile._getTileNameColor()),
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
    (index) => Tile.randomColor('Tile ${index + 1}'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moving Tiles'),
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
                  selectedIndex=-1;
                });
              });
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          // Deselect the selected tile when tapping outside GridView
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
        (index) => Tile.randomColor('Tile ${index + 1}'),
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
      // Select the tapped tile
      selectedIndex = index;
      updateTiles();
      _updateNeighborSelection();
    } else {
      if (_isNeighbor(index, selectedIndex)) {
        // Swap tiles
        final Tile tempTile = tiles[selectedIndex];
        tiles[selectedIndex] = tiles[index];
        tiles[index] = tempTile;
        selectedIndex = index;

        // Update neighbor selection
        _updateNeighborSelection();

        // Call updateTiles() to update the visual appearance
        updateTiles();
      }
    }
  });
}

void _updateNeighborSelection() {
  if (selectedIndex == -1){
    for (int i = 0; i < tiles.length; i++) {
      tiles[i].isNeighborSelected = false;
    }
  }
  else {
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
