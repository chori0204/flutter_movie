import '../entities/detail.dart';
import '../repositories/detail_repository.dart';

class GetDetailsUseCase {
  final DetailRepository repository;

  GetDetailsUseCase(this.repository);

  Future<List<Detail>> execute() {
    return repository.getAllDetails();
  }
}
