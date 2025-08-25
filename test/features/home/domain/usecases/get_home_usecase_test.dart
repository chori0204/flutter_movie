import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:home/domain/usecases/get_home_usecase.dart';
import 'package:home/domain/repositories/home_repository.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late GetHomesUseCase usecase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    usecase = GetHomesUseCase(mockRepository);
  });

  test('should get list of homes from repository', () async {
    // TODO: 테스트 구현
  });
}
