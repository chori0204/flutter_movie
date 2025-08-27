import 'package:flutter/material.dart';
import 'package:flutter_movie/features/home/presentation/pages/movie_detail_page.dart';
import 'package:flutter_movie/features/home/presentation/widgets/movie_horizontal_list_widget.dart';
import 'package:flutter_movie/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:flutter_movie/core/config/env.dart';

class HomePage extends StatefulWidget {
   final HomeViewModel viewModel;
   const HomePage({super.key, required this.viewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late  HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
    _viewModel.loadAll().then((_) {
    setState(() {}); // 데이터 로드 후 UI 갱신
  });
  }

  Future<void> _refresh() async {
    await _viewModel.loadAll();
    setState(() {}); // re-render after data fetch
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
                child: Text(
                  '가장 인기있는',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              /// 1. 가장 인기 있는 영화 1건 (화면 전체 너비)
              if (_viewModel.popularMovies.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      final movie = _viewModel.popularMovies.first;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailPage(movieId: movie.id),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'movie_${_viewModel.popularMovies.first.id}',
                      child: AspectRatio(
                        aspectRatio: 3 / 4, // 또는 2.0, 원하는 비율로 조정 가능
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            '${Env.imageBaseUrl}${_viewModel.popularMovies.first.posterPath}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              //const SizedBox(height: 10),

              /// 2. 현재 상영중
              MovieHorizontalListWidget(
                movies: _viewModel.nowPlaying,
                title: '현재 상영 중',
              ),
              const SizedBox(height: 5),

              /// 3. 인기 영화 (showRank = true)
              MovieHorizontalListWidget(
                movies: _viewModel.popularMovies.skip(1).toList(), // 첫 영화 제외
                title: '인기 순위',
                showRank: true,
              ),
              const SizedBox(height: 13),        
              /// 4. 평점 높은 순
              MovieHorizontalListWidget(
                movies: _viewModel.topRated,
                title: '평점 높은 영화',
              ),
                const SizedBox(height: 5),
              /// 5. 개봉 예정
              MovieHorizontalListWidget(
                movies: _viewModel.upcoming,
                title: '개봉 예정 영화',
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
