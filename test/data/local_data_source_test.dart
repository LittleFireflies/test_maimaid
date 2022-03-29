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

  group('register', () {
    test(
      'register new user '
      'when user not exist',
      () async {
        // arrange
        when(() => userBox.get(user.email)).thenReturn(null);
        when(() => userBox.put(user.email, userModel))
            .thenAnswer((invocation) => Future.value());
        // act
        await hive.registerUser(user);
        // assert
        verify(() => userBox.put(user.email, userModel));
      },
    );

    test(
      'throw UserAlreadyExistException '
      'when email already exist',
      () {
        // arrange
        when(() => userBox.get(user.email)).thenReturn(userModel);
        // act
        final call = hive.registerUser(user);
        // assert
        expect(() => call, throwsA(isA<UserAlreadyExistException>()));
      },
    );
  });

  group('login', () {
    test(
      'return user '
      'when login success',
      () async {
        // arrange
        when(() => userBox.get(user.email)).thenReturn(userModel);
        // act
        final result = await hive.login(user.email, user.password);
        // assert
        expect(result, user);
      },
    );

    test(
      'throw UserNotFoundException '
      'when email incorrect',
      () async {
        // arrange
        when(() => userBox.get(user.email)).thenReturn(null);
        // act
        final call = hive.login(user.email, user.password);
        // assert
        expect(() => call, throwsA(isA<UserNotFoundException>()));
      },
    );

    test(
      'throw LoginFailedException '
      'when password incorrect',
      () async {
        // arrange
        when(() => userBox.get(user.email)).thenReturn(userModel);
        // act
        final call = hive.login(user.email, 'wrong password');
        // assert
        expect(() => call, throwsA(isA<LoginFailedException>()));
      },
    );
  });
}
