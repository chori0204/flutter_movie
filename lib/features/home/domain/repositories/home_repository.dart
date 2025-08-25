import '../entities/home.dart';

abstract class HomeRepository {
  Future<List<Home>> getAllHomes();
}
