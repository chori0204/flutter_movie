import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get tmdbApiKey => dotenv.env['TMDB_API_KEY'] ?? '';
  static String get tmdbAccessToken => dotenv.env['TMDB_ACCESS_TOKEN'] ?? '';
  static String get baseUrl => dotenv.env['TMDB_BASE_URL'] ?? '';
  static String get imageBaseUrl => dotenv.env['TMDB_IMAGE_BASE_URL'] ?? '';

  static String get nowPlayingUrl => dotenv.env['TMDB_NOW_PLAYING_URL'] ?? '';
  static String get popularUrl => dotenv.env['TMDB_POPULAR_URL'] ?? '';
  static String get topRatedUrl => dotenv.env['TMDB_TOP_RATED_URL'] ?? '';
  static String get upcomingUrl => dotenv.env['TMDB_UPCOMING_URL'] ?? '';
  static String get detailUrl => dotenv.env['TMDB_DETAIL_URL'] ?? '';
}
  