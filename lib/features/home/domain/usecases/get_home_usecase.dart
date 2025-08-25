import '../entities/home.dart';
import '../repositories/home_repository.dart';

class GetHomesUseCase {
  final HomeRepository repository;

  GetHomesUseCase(this.repository);

  Future<List<Home>> execute() {
    return repository.getAllHomes();
  }
}
