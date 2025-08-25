import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:detail_page/data/datasources/detail_page_datasource.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late UdetailUpageRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = UdetailUpageRemoteDataSourceImpl(mockDio);
  });

  test('should fetch list of detail_pages from remote API', () async {
    // TODO: 테스트 구현
  });
}
