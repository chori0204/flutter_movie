import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:home_page/data/repositories/home_page_repository_impl.dart';
import 'package:home_page/data/datasources/home_page_datasource.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  late RepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = RepositoryImpl(mockRemoteDataSource);
  });

  test('should get list of home_pages from remote data source', () async {
    // TODO: 테스트 구현
  });
}
