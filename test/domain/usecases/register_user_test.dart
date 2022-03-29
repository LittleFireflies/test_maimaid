import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_maimaid/domain/repositories/user_repository.dart';
import 'package:test_maimaid/domain/usecases/register_user.dart';

import '../../helpers/models.dart';

class MockRepository extends Mock implements UserRepository {}

void main() {
  group('Register User', () {
    late UserRepository repository;
    late RegisterUser usecase;

    const user = TestModels.user;

    setUp(() {
      repository = MockRepository();
      usecase = RegisterUser(repository);
    });

    test(
      'verify registerUser is called '
      'when use case executed',
      () async {
        // arrange
        when(() => repository.registerUser(user))
            .thenAnswer((invocation) => Future.value());
        // act
        await usecase.execute(user);
        // assert
        verify(() => repository.registerUser(user)).called(1);
      },
    );
  });
}
