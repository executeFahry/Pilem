import 'package:flutter/material.dart';
import 'package:pilem/models/movie_model.dart';
import 'package:pilem/models/genre.dart';
import 'package:pilem/api/api.dart';
import 'package:pilem/constants.dart';
import 'package:pilem/pages/details_page.dart';

class MoviesByGenrePage extends StatefulWidget {
  final Genre genre;

  const MoviesByGenrePage({super.key, required this.genre});

  @override
  State<MoviesByGenrePage> createState() => _MoviesByGenrePageState();
}

class _MoviesByGenrePageState extends State<MoviesByGenrePage> {
  late Future<List<MovieModel>> moviesFuture;

  @override
  void initState() {
    super.initState();
    // Ambil data film berdasarkan genre dari API saat halaman film berdasarkan genre dibuka
    moviesFuture = Api().getMoviesByGenre(widget.genre.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genre.name),
      ),
      body: FutureBuilder<List<MovieModel>>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final movies = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(movie: movie),
                      ),
                    );
                  },
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(movie.title ?? 'No Title'),
                    ),
                    child: Image.network(
                      '${Constants.imagePath}${movie.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No movies found'));
          }
        },
      ),
    );
  }
}
