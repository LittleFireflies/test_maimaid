import 'package:test_maimaid/data/api/api_service.dart';
import 'package:test_maimaid/data/local_storage/local_data_source.dart';
import 'package:test_maimaid/domain/entities/user.dart';
import 'package:test_maimaid/domain/entities/user_data.dart';
import 'package:test_maimaid/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  UserRepositoryImpl({
    required LocalDataSource localDataSource,
    required RemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<void> registerUser(User user) async {
    await _localDataSource.registerUser(user);
  }

  @override
  Future<User> login(String email, String password) async {
    return await _localDataSource.login(email, password);
  }

  @override
  Future<List<UserData>> loadUsers() {
    // TODO: implement loadUsers
    throw UnimplementedError();
  }
}
