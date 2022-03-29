import 'package:test_maimaid/domain/entities/user.dart';
import 'package:test_maimaid/domain/repositories/user_repository.dart';

class RegisterUser {
  final UserRepository _repository;

  const RegisterUser(UserRepository repository) : _repository = repository;

  Future<void> execute(User user) async {
    _repository.registerUser(user);
  }
}
