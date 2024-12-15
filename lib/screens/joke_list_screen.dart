import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke.dart';

class JokeListScreen extends StatelessWidget {
  final String type;

  JokeListScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$type Jokes'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ApiService.getJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView(
              children: snapshot.data!.map((joke) {
                return ListTile(
                  title: Text(joke['setup']),
                  subtitle: Text(joke['punchline']),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
