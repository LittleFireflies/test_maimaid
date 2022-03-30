import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_maimaid/data/api/api_service.dart';
import 'package:test_maimaid/data/api/interceptors/error_interceptor.dart';
import 'package:test_maimaid/data/local_storage/local_data_source.dart';
import 'package:test_maimaid/data/models/user_model.dart';
import 'package:test_maimaid/data/repositories/user_repository_impl.dart';
import 'package:test_maimaid/domain/entities/user_data.dart';
import 'package:test_maimaid/presentation/home/view/home_page.dart';
import 'package:test_maimaid/presentation/login/view/login_page.dart';
import 'package:test_maimaid/presentation/register/views/register_page.dart';
import 'package:test_maimaid/presentation/user_detail/view/user_detail_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());

  final userBox = await Hive.openBox<UserModel>(UserHive.userKey);
  final userHive = UserHive.create(userBox: userBox);

  runApp(MyApp(dataSource: userHive));
}

class MyApp extends StatelessWidget {
  final LocalDataSource dataSource;

  const MyApp({
    Key? key,
    required this.dataSource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultTimeoutInSeconds = 60 * 1000;
    final dio = Dio(
      BaseOptions(
        connectTimeout: defaultTimeoutInSeconds,
        receiveTimeout: defaultTimeoutInSeconds,
        sendTimeout: defaultTimeoutInSeconds,
      ),
    );
    dio.interceptors.add(ErrorInterceptor());

    return RepositoryProvider(
      create: (context) => UserRepositoryImpl(
        localDataSource: dataSource,
        remoteDataSource: ApiService(dio),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.interTextTheme(),
        ),
        initialRoute: LoginPage.routeName,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case LoginPage.routeName:
              return MaterialPageRoute(builder: (context) => const LoginPage());
            case RegisterPage.routeName:
              return MaterialPageRoute(
                  builder: (context) => const RegisterPage());
            case HomePage.routeName:
              return MaterialPageRoute(builder: (context) => const HomePage());
            case UserDetailPage.routeName:
              final user = settings.arguments as UserData;
              return MaterialPageRoute(
                builder: (context) => UserDetailPage(user: user),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
