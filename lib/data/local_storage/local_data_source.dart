import 'package:test_maimaid/domain/entities/user.dart';

abstract class LocalDataSource {
  void registerUser(User user);
}
