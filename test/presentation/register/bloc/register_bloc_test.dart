import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_maimaid/domain/usecases/register_user.dart';
import 'package:test_maimaid/presentation/register/bloc/register_bloc.dart';
import 'package:test_maimaid/presentation/register/bloc/register_event.dart';
import 'package:test_maimaid/presentation/register/bloc/register_state.dart';
import 'package:test_maimaid/presentation/register/models/email.dart';
import 'package:test_maimaid/presentation/register/models/name.dart';
import 'package:test_maimaid/presentation/register/models/password.dart';

class MockRegisterUser extends Mock implements RegisterUser {}

void main() {
  group('RegisterBloc', () {
    late RegisterUser registerUser;
    late RegisterBloc bloc;

    setUp(() {
      registerUser = MockRegisterUser();
      bloc = RegisterBloc(registerUser: registerUser);
    });

    group('error validation', () {
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
        'emits email empty error '
        'when email is empty',
        build: () => bloc,
        act: (bloc) => bloc.add(const RegisterEmailChanged('')),
        expect: () => [
          const RegisterState(
            status: FormzStatus.invalid,
            email: Email.dirty(value: ''),
            emailError: 'Email can not be empty!',
          )
        ],
      );

      blocTest<RegisterBloc, RegisterState>(
        'emits email invalid format error '
        'when email is invalid',
        build: () => bloc,
        act: (bloc) => bloc.add(const RegisterEmailChanged('random_email')),
        expect: () => [
          const RegisterState(
            status: FormzStatus.invalid,
            email: Email.dirty(value: 'random_email'),
            emailError: 'Email format invalid!',
          )
        ],
      );

      blocTest<RegisterBloc, RegisterState>(
        'emits password empty error '
        'when password is empty',
        build: () => bloc,
        act: (bloc) => bloc.add(const RegisterPasswordChanged('')),
        expect: () => [
          const RegisterState(
            status: FormzStatus.invalid,
            password: Password.dirty(value: ''),
            passwordError: 'Password can not be empty!',
          )
        ],
      );
    });
  });
}
