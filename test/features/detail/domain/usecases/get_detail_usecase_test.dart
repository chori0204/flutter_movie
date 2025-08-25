import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:detail/domain/usecases/get_detail_usecase.dart';
import 'package:detail/domain/repositories/detail_repository.dart';

class MockDetailRepository extends Mock implements DetailRepository {}

void main() {
  late GetDetailsUseCase usecase;
  late MockDetailRepository mockRepository;

  setUp(() {
    mockRepository = MockDetailRepository();
    usecase = GetDetailsUseCase(mockRepository);
  });

  test('should get list of details from repository', () async {
    // TODO: 테스트 구현
  });
}
