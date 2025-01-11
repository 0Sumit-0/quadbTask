import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../home/application/show_model.dart';

class SearchProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  String _query = 'all';
  List<Movie> _movies = [];
  bool _isLoading = false;

  String get query => _query;
  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;

  void updateQuery(String newQuery) {
    if(newQuery!='') {
      _query = newQuery;
      fetchMovies();
    }
  }

  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get('https://api.tvmaze.com/search/shows?q=${_query}');
      List<dynamic> data = response.data;
      _movies = data
          .map((item) => MovieResponse.fromJson(item as Map<String, dynamic>))
          .map((movieResponse) => movieResponse.show)
          .toList();

    } catch (e) {
      _movies = [];
    }

    _isLoading = false;
    notifyListeners();
  }



}
