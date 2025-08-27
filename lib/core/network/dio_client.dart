import 'package:dio/dio.dart';
import '../config/env.dart';

class DioClient {
  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        queryParameters: {
          'api_key': Env.tmdbApiKey, //  API 키를 기본 파라미터로 추가
        },
        headers: {
          'Authorization': 'Bearer ${Env.tmdbAccessToken}',
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}
