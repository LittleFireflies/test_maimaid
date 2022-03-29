import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:test_maimaid/presentation/register/models/email.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final Email email;
  final String? emailError;

  const LoginState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.emailError,
  });

  LoginState copyWith({
    FormzStatus? status,
    Email? email,
    String? emailError,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      emailError: emailError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        emailError,
      ];
}
