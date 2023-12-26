import 'package:http/http.dart' as http;
import 'dart:convert';

List actors = [];

getActors(int id) async {
  final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/$id/credits'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNTE3ZTFlNjNhY2M3ZTAxYjYwMmVjYTk3YTA2NGQ5OSIsInN1YiI6IjY0NzhhMDFmMGUyOWEyMDBkY2I5OWIxYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.e3Bn2LcLyc7Jgyg8n7tx6Zy1o-Z42uDBX2PKBOGZhwQ'
      });
  final decodedJson = jsonDecode(response.body);
  actors = decodedJson['cast'];
  return actors;
}
