import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:test_maimaid/presentation/register/models/email.dart';
import 'package:test_maimaid/presentation/register/models/name.dart';
import 'package:test_maimaid/presentation/register/models/password.dart';

class RegisterState extends Equatable {
  final FormzStatus? status;
  final Name name;
  final Email email;
  final Password password;
  final String? nameError;
  final String? emailError;
  final String? passwordError;

  const RegisterState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.nameError,
    this.emailError,
    this.passwordError,
  });

  RegisterState copyWith({
    FormzStatus? status,
    Name? name,
    Email? email,
    Password? password,
    String? nameError,
    String? emailError,
    String? passwordError,
  }) {
    return RegisterState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      nameError: nameError,
      emailError: emailError,
      passwordError: passwordError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        email,
        password,
        nameError,
        emailError,
        passwordError,
      ];
}
