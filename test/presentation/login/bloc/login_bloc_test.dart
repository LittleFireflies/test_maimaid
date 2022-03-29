import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_maimaid/domain/usecases/login.dart';
import 'package:test_maimaid/presentation/login/bloc/login_bloc.dart';
import 'package:test_maimaid/presentation/login/bloc/login_event.dart';
import 'package:test_maimaid/presentation/login/bloc/login_state.dart';
import 'package:test_maimaid/presentation/register/models/email.dart';
import 'package:test_maimaid/presentation/register/models/password.dart';

import '../../../helpers/models.dart';

class MockLogin extends Mock implements Login {}

void main() {
  group('LoginBloc', () {
    late Login login;
    late LoginBloc bloc;

    const user = TestModels.user;
    final email = user.email;
    final password = user.password;

    setUp(() {
      login = MockLogin();
      bloc = LoginBloc(login: login);
    });

    group('error validation', () {
      blocTest<LoginBloc, LoginState>(
        'emits email empty error '
        'when email is empty',
        build: () => bloc,
        act: (bloc) => bloc.add(const LoginEmailChanged('')),
        expect: () => [
          const LoginState(
            status: FormzStatus.invalid,
            email: Email.dirty(''),
            emailError: 'Email can not be empty!',
          )
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits email invalid format error '
        'when email is invalid',
        build: () => bloc,
        act: (bloc) => bloc.add(const LoginEmailChanged('random_email')),
        expect: () => [
          const LoginState(
            status: FormzStatus.invalid,
            email: Email.dirty('random_email'),
            emailError: 'Email format invalid!',
          )
        ],
      );

      blocTest<LoginBloc, LoginState>(
        'emits password empty error '
        'when password is empty',
        build: () => bloc,
        act: (bloc) => bloc.add(const LoginPasswordChanged('')),
        expect: () => [
          const LoginState(
            status: FormzStatus.invalid,
            password: Password.dirty(''),
            passwordError: 'Password can not be empty!',
          )
        ],
      );
    });

    blocTest<LoginBloc, LoginState>(
      'emit valid state when '
      'LoginSubmitted event is added '
      'and register success',
      setUp: () {
        when(() => login.execute(email, password))
            .thenAnswer((invocation) => Future.value());
      },
      build: () => bloc,
      act: (bloc) => bloc
        ..add(LoginEmailChanged(email))
        ..add(LoginPasswordChanged(password))
        ..add(const LoginSubmitted()),
      expect: () => [
        LoginState(
          email: Email.dirty(email),
          status: FormzStatus.invalid,
        ),
        LoginState(
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.valid,
        ),
        LoginState(
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.submissionInProgress,
        ),
        LoginState(
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.submissionSuccess,
        ),
      ],
    );

    final exception = Exception('Error!');

    blocTest<LoginBloc, LoginState>(
      'emit valid state when '
      'LoginSubmitted event is added '
      'and error occurred',
      setUp: () {
        when(() => login.execute(email, password)).thenThrow(exception);
      },
      build: () => bloc,
      act: (bloc) => bloc
        ..add(LoginEmailChanged(email))
        ..add(LoginPasswordChanged(password))
        ..add(const LoginSubmitted()),
      expect: () => [
        LoginState(
          email: Email.dirty(email),
          status: FormzStatus.invalid,
        ),
        LoginState(
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.valid,
        ),
        LoginState(
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.submissionInProgress,
        ),
        LoginState(
          email: Email.dirty(email),
          password: Password.dirty(password),
          status: FormzStatus.submissionFailure,
          loginError: exception.toString(),
        ),
      ],
    );
  });
}
