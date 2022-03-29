import 'package:hive/hive.dart';
import 'package:test_maimaid/data/models/user_model.dart';
import 'package:test_maimaid/domain/entities/user.dart';

abstract class LocalDataSource {
  void registerUser(User user);
  Future<bool> login(String email, password);
}

class UserHive extends LocalDataSource {
  static const userKey = 'user';
  final Box<UserModel> userBox;

  UserHive._(this.userBox);

  @override
  void registerUser(User user) async {
    final userModel = UserModel(
      name: user.name,
      email: user.email,
      password: user.password,
    );
    await userBox.put(user.email, userModel);
  }

  factory UserHive.create({required Box<UserModel> userBox}) {
    return UserHive._(userBox);
  }

  @override
  Future<bool> login(String email, password) async {
    final userModel = userBox.get(email);

    return userModel != null;
  }
}
