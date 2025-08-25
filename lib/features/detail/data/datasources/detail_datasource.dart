import 'package:dio/dio.dart';
import '../models/detail_model.dart';

abstract class DetailRemoteDataSource {
  Future<List<DetailModel>> fetchDetails();
}

class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  final Dio dio;

  DetailRemoteDataSourceImpl(this.dio);

  @override
  Future<List<DetailModel>> fetchDetails() async {
    final response = await dio.get('/details');
    final data = response.data as List;
    return data.map((json) => DetailModel.fromJson(json)).toList();
  }
}
