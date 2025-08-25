import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:detail/data/datasources/detail_datasource.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late DetailRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = DetailRemoteDataSourceImpl(mockDio);
  });

  test('should fetch list of details from remote API', () async {
    // TODO: 테스트 구현
  });
}
