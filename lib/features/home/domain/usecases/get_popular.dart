import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetPopular {
  final MovieRepository repository;

  GetPopular(this.repository);

  Future<List<Movie>> call({int page = 1}) {
    return repository.getPopular(page: page);
  }
}
