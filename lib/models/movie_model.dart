class MovieModel {
  final String? backdropPath;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final double voteAverage;
  final List<int>? genreIds;

  MovieModel({
    required this.backdropPath,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreIds,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      backdropPath: json['backdrop_path'] ?? "",
      title: json['title'] ?? "",
      originalTitle: json['original_title'] ?? "",
      overview: json['overview'] ?? "",
      posterPath: json['poster_path'] ?? "",
      releaseDate: json['release_date']?.toString() ?? "",
      voteAverage: (json['vote_average']).toDouble(),
      genreIds: List<int>.from(json['genre_ids'] ?? []),
    );
  }
}