import 'package:test_maimaid/domain/entities/user.dart';
import 'package:test_maimaid/domain/entities/user_data.dart';

abstract class UserRepository {
  Future<void> registerUser(User user);
  Future<User> login(String email, String password);
  Future<List<UserData>> loadUsers();
}
