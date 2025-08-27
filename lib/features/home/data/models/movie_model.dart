import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.voteAverage,
    required super.overview,
    required super.releaseDate,
    required super.backdropPath,
    required super.showRanking, 
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ,
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      backdropPath: json['backdrop_path'] ,
      showRanking: json['show_ranking'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'poster_path': posterPath,
        'vote_average': voteAverage,
        'overview': overview,
        'release_date': releaseDate,
        'backdrop_path': backdropPath,
        'show_ranking': showRanking,
      };
}
