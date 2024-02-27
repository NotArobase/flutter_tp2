import 'package:flutter/material.dart';
import 'Exercice1.dart';
import 'Exercice2.dart';
import 'Exercice4.dart';
import 'Exercice5.dart';
import 'Exercice6.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('Exercice 1'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exercise1Page()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Exercice 2'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exercise2Page()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Exercice 4'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exercise4Page()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Exercice 5'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exercise5Page()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Exercice 6'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exercise6Page()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

