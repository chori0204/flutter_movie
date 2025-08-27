import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTopRated {
  final MovieRepository repository;

  GetTopRated(this.repository);

  Future<List<Movie>> call({int page = 1}) {
    return repository.getTopRated(page: page);
  }
}
