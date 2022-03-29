import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_maimaid/domain/usecases/register_user.dart';
import 'package:test_maimaid/presentation/register/bloc/register_bloc.dart';
import 'package:test_maimaid/presentation/register/bloc/register_event.dart';
import 'package:test_maimaid/presentation/register/bloc/register_state.dart';
import 'package:test_maimaid/presentation/register/models/name.dart';

class MockRegisterUser extends Mock implements RegisterUser {}

void main() {
  group('RegisterBloc', () {
    late RegisterUser registerUser;
    late RegisterBloc bloc;

    setUp(() {
      registerUser = MockRegisterUser();
      bloc = RegisterBloc(registerUser: registerUser);
    });

    group('Name validation', () {
      blocTest<RegisterBloc, RegisterState>(
        'emits name validation error '
        'when name is empty',
        build: () => bloc,
        act: (bloc) => bloc.add(const RegisterNameChanged('')),
        expect: () => [
          const RegisterState(
            status: FormzStatus.invalid,
            name: Name.dirty(value: ''),
            nameError: 'Name can not be empty!',
          )
        ],
      );

      blocTest<RegisterBloc, RegisterState>(
        'emits valid state '
        'when name is not empty',
        build: () => bloc,
        act: (bloc) => bloc.add(const RegisterNameChanged('name')),
        expect: () => [
          const RegisterState(
            status: FormzStatus.valid,
            name: Name.dirty(value: 'name'),
            nameError: null,
          )
        ],
      );
    });
  });
}
