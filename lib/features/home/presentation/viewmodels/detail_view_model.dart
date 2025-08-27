
import 'package:flutter/material.dart';
import 'package:flutter_movie/features/home/domain/entities/movie_detail.dart';
import 'package:flutter_movie/features/home/domain/usecases/get_movie_detail.dart';

class DetailViewModel extends ChangeNotifier {
  final GetMovieDetail getMovieDetailUseCase;

  DetailViewModel(this.getMovieDetailUseCase);

  MovieDetail? movieDetail;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchMovieDetail(int movieId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      movieDetail = await getMovieDetailUseCase.call(movieId);
    } catch (e) {
      errorMessage = '❌ 영화 정보를 불러오는 데 실패했습니다.\n${e.toString()}';
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshMovieDetail(int movieId) async {
    movieDetail = null;
    await fetchMovieDetail(movieId);
  }
}
