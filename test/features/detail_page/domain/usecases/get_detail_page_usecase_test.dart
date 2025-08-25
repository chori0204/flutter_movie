import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:detail_page/domain/usecases/get_detail_page_usecase.dart';
import 'package:detail_page/domain/repositories/detail_page_repository.dart';

class MockUdetailUpageRepository extends Mock implements UdetailUpageRepository {}

void main() {
  late GetUdetailUpagesUseCase usecase;
  late MockUdetailUpageRepository mockRepository;

  setUp(() {
    mockRepository = MockUdetailUpageRepository();
    usecase = GetUdetailUpagesUseCase(mockRepository);
  });

  test('should get list of detail_pages from repository', () async {
    // TODO: 테스트 구현
  });
}
