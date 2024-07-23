import 'dart:convert';
import 'package:bloc_test/movie%20app/constants.dart';
import 'package:http/http.dart' as http;

import 'movies_model.dart';

class MovieRepository {
  final baseUrl = 'https://api.themoviedb.org/3/movie/';

  Future<List<Movie>> fetchMovies(String genre) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl$genre?language=en-US&page=1'), headers: {
        'Authorization': authorization,
        'accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        final List<dynamic> results = decodedJson['results'];
        return results.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      print('Error fetching movies: $e');
      throw e;
    }
  }

  Future<List<Movie>> fetchGenreMovies(int genreId) async {
    final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/discover/movie?with_genres=$genreId'),
        headers: {
          'Authorization': authorization,
          'accept': 'application/json'
        });
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      final List<dynamic> results = decodedJson['results'];
      print(results);
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List> getGenres() async {
    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/genre/movie/list'),
        headers: {
          'Authorization': authorization,
          'accept': 'application/json'
        });
    final decodedJson = jsonDecode(response.body);
    return decodedJson['genres'];
  }

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/trending/movie/week'),
        headers: {
          'Authorization': authorization,
          'accept': 'application/json'
        });
    final decodedJson = jsonDecode(response.body);
    final List<dynamic> results = decodedJson['results'];
    return results.map((movie) => Movie.fromJson(movie)).toList();
  }

  Future<Map<String, dynamic>> getMovie(movieId) async {
    final response = await http.get(
      Uri.parse('$baseUrl$movieId'),
      headers: {
        'Authorization': authorization,
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return decodedJson;
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Future<Map<String, dynamic>> getCastAndDirectors(int movieId) async {
    final response = await http.get(Uri.parse('$baseUrl$movieId/credits'),
        headers: {
          'Authorization': authorization,
          'accept': 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return decodedJson;
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Future<Map<String,dynamic>> searchMovies(String query,int page) async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?query=$query&page=$page'),
        headers: {
          'Authorization': authorization,
          'accept': 'application/json'
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return decodedJson;
    } else {
      throw Exception('Failed to load movie');
    }
  }
}
