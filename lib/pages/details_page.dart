import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilem/api/api.dart';
import 'package:pilem/constants.dart';
import 'package:pilem/models/movie_model.dart';
import 'package:pilem/models/genre.dart';
import 'package:pilem/pages/movies_by_genre.dart';
import 'package:pilem/colors.dart';
import 'package:pilem/widgets/home_button.dart';
import 'package:pilem/widgets/back_button.dart';
import 'package:pilem/widgets/rating.dart';
import 'package:pilem/widgets/release_date.dart';

class DetailsPage extends StatefulWidget {
  final MovieModel movie;

  const DetailsPage({super.key, required this.movie});

  @override
  // ignore: library_private_types_in_public_api
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<List<Genre>> genresFuture;

  @override
  void initState() {
    super.initState();
    // Ambil data genre dari API saat halaman detail dibuka
    genresFuture = Api().getGenres();
  }

  // Fungsi untuk mencocokkan genreIds dengan objek Genre
  List<Genre> getGenresByIds(List<int> genreIds, List<Genre> genres) {
    return genreIds.map((id) {
      return genres.firstWhere(
        (genre) => genre.id == id,
        orElse: () => Genre(
            id: 0, name: "Unknown"), // Jika tidak ditemukan, return Unknown
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: const BackBtn(),
            actions: const [
              HomeBtn(),
            ],
            backgroundColor: Colours.scaffoldBgColor,
            expandedHeight: 450,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(bottom: 0),
              centerTitle: true,
              title: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Text(
                  widget.movie.title ?? 'No Title',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.network(
                  '${Constants.imagePath}${widget.movie.posterPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  // Mengambil data genre dari API
                  FutureBuilder<List<Genre>>(
                    future: genresFuture, // Future yang mengambil genre
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        // Mencocokkan genreIds dengan nama genre
                        final genres = getGenresByIds(
                            widget.movie.genreIds!, snapshot.data!);
                        // Menampilkan genre-genre film
                        return Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: genres.map((genre) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MoviesByGenrePage(
                                      genre: genre,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                  horizontal: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  genre.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return const Text('No genres available');
                      }
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.movie.overview ?? 'No Overview Available',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReleaseDate(movies: widget.movie),
                      Rating(movies: widget.movie),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
