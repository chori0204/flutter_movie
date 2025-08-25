import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:home/data/datasources/home_datasource.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late HomeRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = HomeRemoteDataSourceImpl(mockDio);
  });

  test('should fetch list of homes from remote API', () async {
    // TODO: 테스트 구현
  });
}
