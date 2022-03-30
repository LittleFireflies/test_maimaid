import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_maimaid/data/api/api_service.dart';
import 'package:test_maimaid/data/local_storage/local_data_source.dart';
import 'package:test_maimaid/data/repositories/user_repository_impl.dart';

import '../../helpers/models.dart';

class MockLocalDataSource extends Mock implements LocalDataSource {}

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  group('User Repository Impl', () {
    late LocalDataSource localDataSource;
    late RemoteDataSource remoteDataSource;
    late UserRepositoryImpl repository;

    const user = TestModels.user;
    final email = user.email;
    final password = user.password;

    setUp(() {
      localDataSource = MockLocalDataSource();
      remoteDataSource = MockRemoteDataSource();
      repository = UserRepositoryImpl(
        localDataSource: localDataSource,
        remoteDataSource: remoteDataSource,
      );
    });

    test('register user to local storage', () {
      // arrange
      when(() => localDataSource.registerUser(user))
          .thenAnswer((invocation) => Future.value());
      // act
      repository.registerUser(user);
      // assert
      verify(() => localDataSource.registerUser(user)).called(1);
    });

    test('verify localDataSource.login', () {
      // arrange
      when(() => localDataSource.login(email, password))
          .thenAnswer((_) async => user);
      // act
      repository.login(email, password);
      // assert
      verify(() => localDataSource.login(email, password)).called(1);
    });
  });
}
