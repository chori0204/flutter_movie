import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return remoteDataSource.getNowPlaying(page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return remoteDataSource.getPopular(page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return remoteDataSource.getTopRated(page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return remoteDataSource.getUpcoming(page);
  }

  @override
  Future<MovieDetail> getMovieDetail(int movieId) {
    return remoteDataSource.getMovieDetail(movieId);
  }
}
