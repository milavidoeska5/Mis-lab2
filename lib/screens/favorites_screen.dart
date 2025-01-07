import 'package:flutter/material.dart';
import '../utils/globals.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Jokes'),
      ),
      body: favoriteJokes.isEmpty
          ? Center(child: Text('No favorite jokes yet!'))
          : ListView(
        children: favoriteJokes.map((joke) {
          return Card(
            child: ListTile(
              title: Text(joke.setup),
              subtitle: Text(joke.punchline),
            ),
          );
        }).toList(),
      ),
    );
  }
}
