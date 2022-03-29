import 'package:hive/hive.dart';
import 'package:test_maimaid/data/models/user_model.dart';
import 'package:test_maimaid/domain/entities/user.dart';
import 'package:test_maimaid/utils/exceptions.dart';

abstract class LocalDataSource {
  Future<void> registerUser(User user);
  Future<User> login(String email, password);
}

class UserHive extends LocalDataSource {
  static const userKey = 'user';
  final Box<UserModel> userBox;

  UserHive._(this.userBox);

  @override
  Future<void> registerUser(User user) async {
    final userOrNull = userBox.get(user.email);

    if (userOrNull == null) {
      final userModel = UserModel(
        name: user.name,
        email: user.email,
        password: user.password,
      );
      await userBox.put(user.email, userModel);
    } else {
      throw const UserAlreadyExistException();
    }
  }

  factory UserHive.create({required Box<UserModel> userBox}) {
    return UserHive._(userBox);
  }

  @override
  Future<User> login(String email, password) async {
    final userModel = userBox.get(email);

    if (userModel != null) {
      return userModel.toEntity();
    } else {
      throw const UserNotFoundException();
    }
  }
}
