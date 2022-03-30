import 'package:test_maimaid/domain/entities/user_data.dart';
import 'package:test_maimaid/domain/repositories/user_repository.dart';

class LoadUsers {
  final UserRepository _repository;

  const LoadUsers(UserRepository repository) : _repository = repository;

  Future<List<UserData>> execute() async {
    return await _repository.loadUsers();
  }
}
