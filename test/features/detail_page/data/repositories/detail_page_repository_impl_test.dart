import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:detail_page/data/repositories/detail_page_repository_impl.dart';
import 'package:detail_page/data/datasources/detail_page_datasource.dart';

class MockRemoteDataSource extends Mock implements UdetailUpageRemoteDataSource {}

void main() {
  late UdetailUpageRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = UdetailUpageRepositoryImpl(mockRemoteDataSource);
  });

  test('should get list of detail_pages from remote data source', () async {
    // TODO: 테스트 구현
  });
}
