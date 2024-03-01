import 'package:flutter/material.dart';
import 'Exercice1.dart';
import 'Exercice2.dart';
import 'Exercice4.dart';
import 'Exercice5.dart';
import 'Exercice6.dart';
import 'Exercice7.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TP2 Flutter'),
      ),
      body: ListView(
        children: [
          buildExerciseListItem(context, 'Exercice 1', 'Affiche une image aléatoire', Exercise1Page()),
          buildExerciseListItem(context, 'Exercice 2', "Affiche une image que l'on peut tourner", Exercise2Page()),
          buildExerciseListItem(context, 'Exercice 4', 'Affiche une image et sa version cropped', Exercise4Page()),
          buildExerciseListItem(context, 'Exercice 5', 'Affiche une image sous forme de mosaïque', Exercise5Page()),
          buildExerciseListItem(context, 'Exercice 6', 'Simule le jeu taquin avec des numéros et couleurs', Exercise6Page()),
          buildExerciseListItem(context, 'Exercice 7', 'Jeu taquin avec images', const Exercise7Page()),
        ],
      ),
    );
  }

  Widget buildExerciseListItem(BuildContext context, String title, String description, Widget page) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}