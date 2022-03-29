import 'package:test_maimaid/data/local_storage/local_data_source.dart';
import 'package:test_maimaid/domain/entities/user.dart';
import 'package:test_maimaid/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final LocalDataSource _localDataSource;

  UserRepositoryImpl({required LocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<void> registerUser(User user) async {
    _localDataSource.registerUser(user);
  }

  @override
  Future<User> login(String email, String password) async {
    return await _localDataSource.login(email, password);
  }
}
