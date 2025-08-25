import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:home/data/repositories/home_repository_impl.dart';
import 'package:home/data/datasources/home_datasource.dart';

class MockRemoteDataSource extends Mock implements HomeRemoteDataSource {}

void main() {
  late HomeRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = HomeRepositoryImpl(mockRemoteDataSource);
  });

  test('should get list of homes from remote data source', () async {
    // TODO: 테스트 구현
  });
}
