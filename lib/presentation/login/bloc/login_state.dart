import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:test_maimaid/presentation/register/models/email.dart';
import 'package:test_maimaid/presentation/register/models/password.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final Email email;
  final Password password;
  final String? emailError;
  final String? passwordError;
  final String? loginError;

  const LoginState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.emailError,
    this.passwordError,
    this.loginError,
  });

  LoginState copyWith({
    FormzStatus? status,
    Email? email,
    Password? password,
    String? emailError,
    String? passwordError,
    String? loginError,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      loginError: loginError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        emailError,
        passwordError,
        loginError,
      ];
}
