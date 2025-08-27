import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movie/core/network/dio_client.dart';
import 'package:flutter_movie/features/home/data/datasources/movie_remote_datasource.dart';
import 'package:flutter_movie/features/home/data/repositories/movie_repository_impl.dart';
import 'package:flutter_movie/features/home/domain/usecases/get_movie_detail.dart';
import 'package:flutter_movie/features/home/presentation/viewmodels/detail_view_model.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late final DetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    final dio = DioClient.create();
    final dataSource = MovieRemoteDataSourceImpl(dio);
    final repository = MovieRepositoryImpl(dataSource);
    final getMovieDetailUseCase = GetMovieDetail(repository);

    _viewModel = DetailViewModel(getMovieDetailUseCase);

    _fetchDetail();
  }

  Future<void> _fetchDetail() async {
    await _viewModel.fetchMovieDetail(widget.movieId);
    setState(() {}); // ⬅️ 상태 변경 반영
  }

  @override
  Widget build(BuildContext context) {
    final detail = _viewModel.movieDetail;

    return Scaffold(
     
      body: detail == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),                   
                  ),
                  Hero(
                      tag: detail.id,
                      child: AspectRatio(
                        aspectRatio: 3 / 4, // 또는 2.0, 원하는 비율로 조정 가능
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                             '${dotenv.env['TMDB_IMAGE_BASE_URL'] ?? ''}${detail.posterPath}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          detail.title,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                       Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            detail.releaseDate != null && detail.releaseDate!.isNotEmpty
                                ? detail.releaseDate!.substring(0, 10) + '   '
                                : 'N/A',
                             overflow: TextOverflow.ellipsis,
                             maxLines: 1,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                          detail.runtime.bitLength > 0 ? '${detail.runtime}분' : 'N/A',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]
                  ),
                  
                 Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Colors.white,
                      thickness: 0.5,
                      height: 20,  // 위아래 여백 포함
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20), // 좌우 패딩 20
                    child: Row(
                      children: [
                        Wrap(alignment: WrapAlignment.start, // 👉 아이템 좌정렬
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: detail.genres.map((genre) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white54),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                genre,
                                style: const TextStyle(color: Colors.blueAccent),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                    Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Colors.white,
                      thickness: 0.5,
                      height: 20,  // 위아래 여백 포함
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      detail.overview,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Colors.white,
                      thickness: 0.5,
                      height: 20,  // 위아래 여백 포함
                    ),
                  ),
                  
                  Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        height: 60, // 높이 고정 (원하는 값으로 조절)
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          textAlign: TextAlign.center, // 텍스트 중앙 정렬
                          '${detail.voteAverage}\n평점',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        height: 60, // 높이 고정 (원하는 값으로 조절)
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          textAlign: TextAlign.center, // 텍스트 중앙 정렬
                          '${detail.voteCount}\n투표수',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        height: 60, // 높이 고정 (원하는 값으로 조절)
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          textAlign: TextAlign.center, // 텍스트 중앙 정렬
                          '${detail.popularity}\n인기점수',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        height: 60, // 높이 고정 (원하는 값으로 조절)
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          textAlign: TextAlign.center, // 텍스트 중앙 정렬
                          '${detail.budget}\n예산',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        height: 60, // 높이 고정 (원하는 값으로 조절)
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          textAlign: TextAlign.center, // 텍스트 중앙 정렬
                          '${detail.revenue}\n수익',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
