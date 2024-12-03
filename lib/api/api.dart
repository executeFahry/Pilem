import 'dart:convert';
import 'package:pilem/constants.dart';
import 'package:pilem/models/movie_model.dart';
import 'package:pilem/models/genre.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String _trendingMovieUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';
  static const String _topRatedMovieUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';
  static const String _upcomingMovieUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';
  static const String _genreUrl =
      'https://api.themoviedb.org/3/genre/movie/list?api_key=${Constants.apiKey}';

  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingMovieUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(_topRatedMovieUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<List<MovieModel>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(_upcomingMovieUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<List<Genre>> getGenres() async {
    final response = await http.get(Uri.parse(_genreUrl));
    if (response.statusCode == 200) {
      final List decodedData = json.decode(response.body)['genres'] as List;
      return decodedData.map((genre) => Genre.fromJson(genre)).toList();
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<List<MovieModel>> getMoviesByGenre(int genreId) async {
    final String url =
        'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&with_genres=$genreId';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies by genre');
    }
  }
}
