import 'package:dio/dio.dart';
import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeModel>> fetchHomes();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<List<HomeModel>> fetchHomes() async {
    final response = await dio.get('/homes');
    final data = response.data as List;
    return data.map((json) => HomeModel.fromJson(json)).toList();
  }
}
