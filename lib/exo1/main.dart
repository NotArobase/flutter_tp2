import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Image alÃ©atoire"),
        ),
        body: Center(
          child: Image.network(
            'https://picsum.photos/512/1024',
            width: 512,
            height: 1024,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}