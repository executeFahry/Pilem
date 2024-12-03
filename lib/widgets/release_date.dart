import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilem/models/movie_model.dart';
import 'package:intl/intl.dart'; // Import intl untuk format tanggal

class ReleaseDate extends StatelessWidget {
  const ReleaseDate({
    super.key,
    required this.movies,
  });

  final MovieModel movies;

  // Fungsi untuk memformat tanggal rilis menjadi DD-MM-YYYY
  String formatReleaseDate(String releaseDate) {
    try {
      DateTime dateTime =
          DateTime.parse(releaseDate); // Mengubah string ke DateTime
      return DateFormat('dd-MM-yyyy').format(dateTime); // Format tanggal
    } catch (e) {
      return releaseDate; // Jika gagal, tampilkan string asli
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            'Date: ',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            formatReleaseDate(movies.releaseDate ?? 'No Release Date'),
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
