class MovieDetail {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final int runtime;
  final String tagline;
  final List<String> genres;
  final double popularity;
  final String budget;
  final String revenue;
  final List<String> productionCompanies;

  MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.runtime,
    required this.tagline,
    required this.genres,
    required this.popularity,
    required this.budget,
    required this.revenue,
    required this.productionCompanies,
  });
}
