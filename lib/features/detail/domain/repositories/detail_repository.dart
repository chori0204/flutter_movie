import '../entities/detail.dart';

abstract class DetailRepository {
  Future<List<Detail>> getAllDetails();
}
