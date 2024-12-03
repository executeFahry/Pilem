import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilem/colors.dart';

import '../models/movie_model.dart';

class Rating extends StatelessWidget {
  const Rating({
    super.key,
    required this.movies,
  });

  final MovieModel movies;

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
            'Rating: ',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(
            Icons.star,
            color: Colours.ratingColor,
          ),
          Text(
            '${movies.voteAverage.toStringAsFixed(1)}/10',
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
