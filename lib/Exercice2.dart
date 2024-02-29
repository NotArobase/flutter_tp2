import 'package:flutter/material.dart';

class Exercise2Page extends StatefulWidget {
  @override
  _Exercise2PageState createState() => _Exercise2PageState();
}

class _Exercise2PageState extends State<Exercise2Page> {
  double _rotationX = 0;
  double _rotationY = 0;
  double _scaleValue = 1.0;
  bool _mirrored = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotation de l\'image'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(_rotationX)
                ..rotateY(_rotationY)
                ..scale(_mirrored ? -_scaleValue : _scaleValue),
              alignment: Alignment.center,
              child: ClipRect(
                child: Container(
                  width: 300,
                  height: 200,
                  color: Colors.grey[300],
                  child: Image.network(
                    'https://picsum.photos/512/1024',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Rotation X'),
                Slider(
                  value: _rotationX,
                  min: -180 * (3.141592653589793 / 180),
                  max: 180 * (3.141592653589793 / 180),
                  divisions: 360,
                  onChanged: (value) {
                    setState(() {
                      _rotationX = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Rotation Y'),
                Slider(
                  value: _rotationY,
                  min: -180 * (3.141592653589793 / 180),
                  max: 180 * (3.141592653589793 / 180),
                  divisions: 360,
                  onChanged: (value) {
                    setState(() {
                      _rotationY = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Échelle'),
                Slider(
                  value: _scaleValue,
                  min: 0.1,
                  max: 2.0,
                  divisions: 20,
                  onChanged: (value) {
                    setState(() {
                      _scaleValue = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _mirrored = !_mirrored;
                    });
                  },
                  child: Text(_mirrored ? 'Unmirror' : 'Mirror'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
