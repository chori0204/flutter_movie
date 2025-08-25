import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:detail/data/repositories/detail_repository_impl.dart';
import 'package:detail/data/datasources/detail_datasource.dart';

class MockRemoteDataSource extends Mock implements DetailRemoteDataSource {}

void main() {
  late DetailRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = DetailRepositoryImpl(mockRemoteDataSource);
  });

  test('should get list of details from remote data source', () async {
    // TODO: 테스트 구현
  });
}
