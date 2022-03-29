import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_maimaid/domain/usecases/login.dart';
import 'package:test_maimaid/presentation/login/bloc/login_bloc.dart';
import 'package:test_maimaid/presentation/login/bloc/login_event.dart';
import 'package:test_maimaid/presentation/login/bloc/login_state.dart';
import 'package:test_maimaid/presentation/register/models/email.dart';

class MockLogin extends Mock implements Login {}

void main() {
  group('LoginBloc', () {
    late Login login;
    late LoginBloc bloc;

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
    });
  });
}
