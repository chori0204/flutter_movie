import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movie/core/network/dio_client.dart';
import 'package:flutter_movie/features/home/data/datasources/movie_remote_datasource.dart';
import 'package:flutter_movie/features/home/data/repositories/movie_repository_impl.dart';
import 'package:flutter_movie/features/home/presentation/pages/home_page.dart';
import 'package:flutter_movie/features/home/presentation/viewmodels/home_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/config/.env');

  // ✅ Dio 초기화 및 의존성 주입
final dio = DioClient.create();
final remoteDataSource = MovieRemoteDataSourceImpl(dio);
final repository = MovieRepositoryImpl(remoteDataSource);
final viewModel = HomeViewModel(repository);

  runApp(MyApp(viewModel: viewModel));
}

class MyApp extends StatelessWidget {
  final HomeViewModel viewModel;

  const MyApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB Movie App',
      theme: ThemeData.dark(),
      home: HomePage(viewModel: viewModel), // ✅ ViewModel 주입
      debugShowCheckedModeBanner: false,
    );
  }
}
