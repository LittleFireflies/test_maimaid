import 'package:test_maimaid/domain/entities/user.dart';
import 'package:test_maimaid/domain/repositories/user_repository.dart';

class Login {
  final UserRepository _repository;

  const Login(UserRepository repository) : _repository = repository;

  Future<void> execute(String email, String password) async {
    await _repository.login(email, password);
  }
}
