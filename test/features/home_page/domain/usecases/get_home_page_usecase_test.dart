import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:home_page/domain/usecases/get_home_page_usecase.dart';
import 'package:home_page/domain/repositories/home_page_repository.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  late GetsUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetsUseCase(mockRepository);
  });

  test('should get list of home_pages from repository', () async {
    // TODO: 테스트 구현
  });
}
