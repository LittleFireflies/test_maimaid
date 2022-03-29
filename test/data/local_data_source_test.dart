import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_maimaid/data/local_storage/local_data_source.dart';
import 'package:test_maimaid/data/models/user_model.dart';
import 'package:test_maimaid/utils/exceptions.dart';

import '../helpers/models.dart';

class MockUserBox extends Mock implements Box<UserModel> {}

void main() {
  late Box<UserModel> userBox;
  late UserHive hive;

  const user = TestModels.user;
  const userModel = TestModels.userModel;

  setUp(() {
    userBox = MockUserBox();
    hive = UserHive.create(userBox: userBox);
  });

  test('register new user', () async {
    // arrange
    when(() => userBox.get(user.email)).thenReturn(null);
    when(() => userBox.put(user.email, userModel))
        .thenAnswer((invocation) => Future.value());
    // act
    hive.registerUser(user);
    // assert
    verify(() => userBox.put(user.email, userModel));
  });

  test('throw UserAlreadyExistException when email already exist', () {
    // arrange
    when(() => userBox.get(user.email)).thenReturn(userModel);
    // act
    final call = hive.registerUser(user);
    // assert
    expect(() => call, throwsA(isA<UserAlreadyExistException>()));
  });
}
