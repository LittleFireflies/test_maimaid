import 'package:hive/hive.dart';
import 'package:test_maimaid/data/models/user_model.dart';
import 'package:test_maimaid/domain/entities/user.dart';

abstract class LocalDataSource {
  void registerUser(User user);
}

class UserHive extends LocalDataSource {
  static const userKey = 'user';
  final Box<UserModel> userBox;

  UserHive._(this.userBox);

  @override
  void registerUser(User user) {
    final userModel = UserModel(
      name: user.name,
      email: user.email,
      password: user.password,
    );
    userBox.add(userModel);
  }

  factory UserHive.create({required Box<UserModel> userBox}) {
    return UserHive._(userBox);
  }
}
