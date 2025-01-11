import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../application/show_model.dart';

class MovieProvider with ChangeNotifier {
  final Dio _dio = Dio();
  List<Movie> _movies = [];
  bool _isLoading = false;
  Episode? _episode;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  Episode? get episode => _episode;

  int _mainIndex = 0;
  int get mainIndex => _mainIndex;

  void swipeRightAdd(int mainIndex) {
    if (_movies.length - 1 >= mainIndex) {
      _mainIndex += 1;
    }
    notifyListeners();
  }

  void swipeLeftSub(int mainIndex) {
    if (mainIndex >= 1) {
      _mainIndex -= 1;
    }
    notifyListeners();
  }

  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get('https://api.tvmaze.com/search/shows?q=all');
      List<dynamic> data = response.data;
      _movies = data
          .map((item) => MovieResponse.fromJson(item as Map<String, dynamic>))
          .map((movieResponse) => movieResponse.show)
          .toList();
    } catch (e) {
      print("Error fetching movies: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchEpisode(int episodeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get('https://api.tvmaze.com/episodes/$episodeId');
      _episode = Episode.fromJson(response.data);
      print(_episode?.summary);
    } catch (e) {
      print("Error fetching episode: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
