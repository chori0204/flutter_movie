import '../../domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  MovieDetailModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
    required super.runtime,
    required super.voteAverage,
    required super.genres,
  }) : super(backdropPath: '',
             voteCount: 0,
             tagline: '',
             popularity: 0.0,
             budget: '',
             revenue: '',
             productionCompanies: []);

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      runtime: json['runtime'] ?? 0,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      genres: (json['genres'] as List<dynamic>).map((g) => g['name'] as String).toList(),
    );
  }
}
