import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_maimaid/domain/repositories/user_repository.dart';
import 'package:test_maimaid/domain/usecases/load_users.dart';

import '../../helpers/models.dart';

class MockRepository extends Mock implements UserRepository {}

void main() {
  group('load users', () {
    late UserRepository repository;
    late LoadUsers usecase;

    final users = [TestModels.userData];

    setUp(() {
      repository = MockRepository();
      usecase = LoadUsers(repository);
    });

    test(
      'verify loadUsers is called '
      'when use case executed',
      () async {
        // arrange
        when(() => repository.loadUsers()).thenAnswer((_) async => users);
        // act
        final result = await usecase.execute();
        // assert
        expect(result, users);
        verify(() => repository.loadUsers()).called(1);
      },
    );
  });
}
