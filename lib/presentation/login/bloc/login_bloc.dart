import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:test_maimaid/domain/usecases/login.dart';
import 'package:test_maimaid/presentation/login/bloc/login_event.dart';
import 'package:test_maimaid/presentation/login/bloc/login_state.dart';
import 'package:test_maimaid/presentation/register/models/email.dart';
import 'package:test_maimaid/presentation/register/models/password.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login _login;

  LoginBloc({required Login login})
      : _login = login,
        super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) => _onLoginEmailChanged(event, emit));
    on<LoginPasswordChanged>(
        (event, emit) => _onLoginPasswordChanged(event, emit));
  }

  void _onLoginEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);

    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
        emailError: _getEmailError(email.error),
      ),
    );
  }

  void _onLoginPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);

    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password, state.email]),
        passwordError: password.invalid ? 'Password can not be empty!' : null,
      ),
    );
  }
}

String? _getEmailError(EmailInputError? error) {
  switch (error) {
    case EmailInputError.empty:
      return 'Email can not be empty!';
    case EmailInputError.invalidFormat:
      return 'Email format invalid!';
    default:
      return null;
  }
}
