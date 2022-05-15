// Packages
import 'package:dio/dio.dart';
import 'package:flutter_json_practice_at_movie/home/movies_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Models
import 'movie.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  return MovieService();
});

class MovieService {
  final Dio _dio = Dio();
  Future<List<Movie>> getMovies() async {
    try {
      final response = await _dio.get(
          "https://api.themoviedb.org/3/movie/popular?api_key=API-KEY"
      );
      final results = List<Map<String, dynamic>>.from(response.data['results']);
      List<Movie> movies = results
          .map((movieData) => Movie.fromMap(movieData))
          .toList();
      return movies;
    } on DioError catch (dioError) {
      throw MoviesException.fromDioError(dioError);
    }
  }
}
