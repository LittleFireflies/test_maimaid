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

import '../../../helpers/models.dart';

class MockRegisterUser extends Mock implements RegisterUser {}

void main() {
  group('RegisterBloc', () {
    late RegisterUser registerUser;
    late RegisterBloc bloc;

    const user = TestModels.user;
    final name = user.name;
    final email = user.email;
    final password = user.password;

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
            name: Name.dirty(''),
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
            email: Email.dirty(''),
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
            email: Email.dirty('random_email'),
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
            password: Password.dirty(''),
            passwordError: 'Password can not be empty!',
          )
        ],
      );
    });

    blocTest<RegisterBloc, RegisterState>(
      'emit valid state when '
      'all forms are inputted '
      'and register success',
      setUp: () {
        when(() => registerUser.execute(user))
            .thenAnswer((invocation) => Future.value());
      },
      build: () => bloc,
      act: (bloc) => bloc
        ..add(RegisterNameChanged(name))
        ..add(RegisterEmailChanged(email))
        ..add(RegisterPasswordChanged(password))
        ..add(const RegisterSubmitted()),
      expect: () => [
        RegisterState(
          name: Name.dirty(name),
          status: FormzStatus.invalid,
        ),
        RegisterState(
          name: Name.dirty(name),
          email: Email.dirty(email),
          status: FormzStatus.invalid,
        ),
        RegisterState(
          name: Name.dirty(name),
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.valid,
        ),
        RegisterState(
          name: Name.dirty(name),
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.submissionInProgress,
        ),
        RegisterState(
          name: Name.dirty(name),
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.submissionSuccess,
        ),
      ],
    );

    final exception = Exception('Error!');

    blocTest<RegisterBloc, RegisterState>(
      'emit valid state when '
      'all forms are inputted '
      'and error occurred',
      setUp: () {
        when(() => registerUser.execute(user)).thenThrow(exception);
      },
      build: () => bloc,
      act: (bloc) => bloc
        ..add(RegisterNameChanged(name))
        ..add(RegisterEmailChanged(email))
        ..add(RegisterPasswordChanged(password))
        ..add(const RegisterSubmitted()),
      expect: () => [
        RegisterState(
          name: Name.dirty(name),
          status: FormzStatus.invalid,
        ),
        RegisterState(
          name: Name.dirty(name),
          email: Email.dirty(email),
          status: FormzStatus.invalid,
        ),
        RegisterState(
          name: Name.dirty(name),
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.valid,
        ),
        RegisterState(
          name: Name.dirty(name),
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.submissionInProgress,
        ),
        RegisterState(
          name: Name.dirty(name),
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.submissionFailure,
          registerError: exception.toString(),
        ),
      ],
    );
  });
}
