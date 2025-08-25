import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:home_page/data/datasources/home_page_datasource.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late RemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = RemoteDataSourceImpl(mockDio);
  });

  test('should fetch list of home_pages from remote API', () async {
    // TODO: 테스트 구현
  });
}
