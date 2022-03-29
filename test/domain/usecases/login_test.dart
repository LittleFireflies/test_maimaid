import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_maimaid/domain/repositories/user_repository.dart';
import 'package:test_maimaid/domain/usecases/login.dart';

import '../../helpers/models.dart';

class MockRepository extends Mock implements UserRepository {}

void main() {
  group('Login', () {
    late UserRepository repository;
    late Login usecase;

    const user = TestModels.user;

    setUp(() {
      repository = MockRepository();
      usecase = Login(repository);
    });

    test(
      'verify registerUser is called '
      'when use case executed',
      () async {
        // arrange
        when(() => repository.login(user))
            .thenAnswer((invocation) => Future.value());
        // act
        await usecase.execute(user);
        // assert
        verify(() => repository.login(user)).called(1);
      },
    );
  });
}
