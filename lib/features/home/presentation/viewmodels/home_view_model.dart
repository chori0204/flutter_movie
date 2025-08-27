import 'package:flutter/foundation.dart';
import 'package:flutter_movie/features/home/domain/entities/movie.dart';
import 'package:flutter_movie/features/home/domain/usecases/get_now_playing.dart';
import 'package:flutter_movie/features/home/domain/usecases/get_popular.dart';
import 'package:flutter_movie/features/home/domain/usecases/get_top_rated.dart';
import 'package:flutter_movie/features/home/domain/usecases/get_upcoming.dart';
import 'package:flutter_movie/features/home/data/repositories/movie_repository_impl.dart';

class HomeViewModel extends ChangeNotifier {
  final MovieRepositoryImpl _repository;
  HomeViewModel(this._repository); // ✅ 외부에서 주입

  List<Movie> nowPlaying = [];
  List<Movie> popularMovies = [];
  List<Movie> topRated = [];
  List<Movie> upcoming = [];


  bool isLoading = false;
  String? errorMessage;

  Future<void> loadAll() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      nowPlaying = await GetNowPlaying(_repository).call(page: 1);
      popularMovies = await GetPopular(_repository).call(page: 1);
      topRated = await GetTopRated(_repository).call(page: 1);
      upcoming = await GetUpcoming(_repository).call(page: 1);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
