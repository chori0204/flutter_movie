import 'package:flutter/material.dart';
import 'package:flutter_movie/core/config/env.dart';
import 'package:flutter_movie/features/home/domain/entities/movie.dart';
import 'package:flutter_movie/features/home/presentation/pages/movie_detail_page.dart';

class MovieHorizontalListWidget extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final bool showRank;

  const MovieHorizontalListWidget({
    super.key,
    required this.title,
    required this.movies,
    this.showRank = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // 살짝 여유 주는 높이
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 제목
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),

          /// 수평 영화 리스트
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                final imageUrl = '${Env.imageBaseUrl}${movie.posterPath}';
                  // 조건에 따라 margin 설정
                final posterMargin = showRank
                    ? const EdgeInsets.only(left: 40, right: 10)
                    : const EdgeInsets.symmetric(vertical: 10, horizontal: 10);
                print('🔗 이미지 URL: $imageUrl'); // ✅ 여기서 출력
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailPage(movieId: movie.id),
                    ),
                  ),
                  child: Stack(
                    children: [
                      /// 포스터 이미지
                      Container(
                        width: 120, 
                        margin: posterMargin,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 60),
                          )
                        ),
                      ),

                      /// 랭킹 표시 (옵션)
                      if (showRank)
                        Positioned(
                          bottom: -10,
                          left: 15,
                          child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 70,
                                fontWeight: FontWeight.bold,                                
                              ),
                            ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
