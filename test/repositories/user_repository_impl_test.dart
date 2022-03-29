import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_maimaid/data/local_storage/local_data_source.dart';
import 'package:test_maimaid/data/repositories/user_repository_impl.dart';

import '../helpers/models.dart';

class MockLocalDataSource extends Mock implements LocalDataSource {}

void main() {
  group('User Repository Impl', () {
    late LocalDataSource localDataSource;
    late UserRepositoryImpl repository;

    const user = TestModels.user;

    setUp(() {
      localDataSource = MockLocalDataSource();
      repository = UserRepositoryImpl(localDataSource: localDataSource);
    });

    test('register user to local storage', () {
      // act
      repository.registerUser(user);
      // assert
      verify(() => localDataSource.registerUser(user));
    });
  });
}
