import 'package:flutter/material.dart';
import 'package:lab2_mis/models/joke.dart';
import '../services/api_services.dart';
import '../utils/globals.dart';

class JokeListScreen extends StatefulWidget {
  final String type;

  JokeListScreen({required this.type});

  @override
  _JokeListScreenState createState() => _JokeListScreenState();
}

class _JokeListScreenState extends State<JokeListScreen> {
  late Future<List<Joke>> jokes;

  @override
  void initState() {
    super.initState();
    jokes = fetchJokes();
  }

  Future<List<Joke>> fetchJokes() async {
    final jokeData = await ApiService.getJokesByType(widget.type);
    return jokeData.map((joke) => Joke.fromJson(joke)).toList();
  }

  void toggleFavorite(Joke joke) {
    setState(() {
      joke.isFavorite = !joke.isFavorite;
      if (joke.isFavorite) {
        favoriteJokes.add(joke);
      } else {
        favoriteJokes.remove(joke);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} Jokes'),
      ),
      body: FutureBuilder<List<Joke>>(
        future: jokes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView(
              children: snapshot.data!.map((joke) {
                return Card(
                  child: ListTile(
                    title: Text(joke.setup),
                    subtitle: Text(joke.punchline),
                    trailing: IconButton(
                      icon: Icon(
                        joke.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: joke.isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        toggleFavorite(joke);
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}