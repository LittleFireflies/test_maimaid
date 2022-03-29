import 'package:test_maimaid/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> registerUser(User user);
  Future<void> login(User user);
}
