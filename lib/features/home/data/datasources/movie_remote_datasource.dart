import 'package:dio/dio.dart';
//import 'package:flutter_movie/core/network/dio_client.dart'; // DioClient import
import '../models/movie_model.dart';
import '../models/movie_detail_model.dart';
import 'package:flutter_movie/core/config/env.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlaying(int page);
  Future<List<MovieModel>> getPopular(int page);
  Future<List<MovieModel>> getTopRated(int page);
  Future<List<MovieModel>> getUpcoming(int page);
  Future<MovieDetailModel> getMovieDetail(int movieId);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSourceImpl(this.dio); // ✅ 외부에서 Dio 주입

  Future<List<MovieModel>> _fetchList(String endpoint, int page) async {
    try {
      final fullUrl = '${dio.options.baseUrl}$endpoint?page=$page';
      print('📡 요청 URL: $fullUrl');

      final response = await dio.get(endpoint, queryParameters: {
        'language': 'ko-KR',
        'page': page,
      });

      print('✅ 응답 상태 코드: ${response.statusCode}');
      print('📦 응답 데이터: ${response.data}');

      final results = (response.data['results'] as List)
          .map((json) {
            print('🎬 영화 제목: ${json['title']}');
            print('🖼️ poster_path: ${json['poster_path']}');
            print('🖼️ backdrop_path: ${json['backdrop_path']}');
            return MovieModel.fromJson(json);
          })
          .toList();

      return results;
    } catch (e) {
      print('❌ API 호출 실패: $e');
      return [];
    }
  }

  @override
  Future<List<MovieModel>> getNowPlaying(int page) =>
      _fetchList('/movie/now_playing', page);

  @override
  Future<List<MovieModel>> getPopular(int page) =>
      _fetchList('/movie/popular', page);

  @override
  Future<List<MovieModel>> getTopRated(int page) =>
      _fetchList('/movie/top_rated', page);

  @override
  Future<List<MovieModel>> getUpcoming(int page) =>
      _fetchList('/movie/upcoming', page);

  @override
  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    try {
      final response = await dio.get('/movie/$movieId', queryParameters: {
        'language': 'ko-KR','api_key': Env.tmdbApiKey,
      });

      print('🎯 상세 영화 응답: ${response.data}');
      return MovieDetailModel.fromJson(response.data);
    } catch (e) {
      print('❌ 상세 정보 호출 실패: $e');
      rethrow;
    }
  }
}
