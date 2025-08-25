import '../../domain/entities/detail.dart';
import '../../domain/repositories/detail_repository.dart';
import '../datasources/detail_datasource.dart';

class DetailRepositoryImpl implements DetailRepository {
  final DetailRemoteDataSource remoteDataSource;

  DetailRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Detail>> getAllDetails() {
    return remoteDataSource.fetchDetails();
  }
}
