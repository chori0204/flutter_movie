import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetUpcoming {
  final MovieRepository repository;

  GetUpcoming(this.repository);

  Future<List<Movie>> call({int page = 1}) {
    return repository.getUpcoming(page: page);
  }
}
