import 'package:test_maimaid/data/models/user_data_dto.dart';
import 'package:test_maimaid/data/models/user_model.dart';
import 'package:test_maimaid/data/models/user_response.dart';
import 'package:test_maimaid/domain/entities/user.dart';
import 'package:test_maimaid/domain/entities/user_data.dart';

class TestModels {
  static const User user = User(
    name: 'FullName',
    email: 'email@domain.com',
    password: '12345',
  );

  static const UserModel userModel = UserModel(
    name: 'FullName',
    email: 'email@domain.com',
    password: '12345',
  );

  static const UserData userData = UserData(
    id: 1,
    email: 'email',
    firstName: 'firstName',
    lastName: 'lastName',
    avatar: 'avatar',
  );

  static const UserDataDto userDataDto = UserDataDto(
    id: 1,
    email: 'email',
    firstName: 'firstName',
    lastName: 'lastName',
    avatar: 'avatar',
  );

  static const UserResponse userResponse = UserResponse(
    page: 1,
    perPage: 1,
    total: 1,
    totalPages: 1,
    data: [userDataDto],
  );
}
