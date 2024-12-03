import 'package:flutter/material.dart';
import 'package:pilem/models/genre.dart'; // Import model Genre
import 'package:pilem/pages/movies_by_genre.dart'; // Import MoviesByGenrePage

class GenrePage extends StatelessWidget {
  final List<Genre> genres;

  const GenrePage({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Genre Film'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return GestureDetector(
            onTap: () {
              // Navigasi ke MoviesByGenrePage ketika genre diklik
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoviesByGenrePage(genre: genre),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  genre.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
