import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetNowPlaying {
  final MovieRepository repository;

  GetNowPlaying(this.repository);

  Future<List<Movie>> call({int page = 1}) {
    return repository.getNowPlaying(page: page);
  }
}
