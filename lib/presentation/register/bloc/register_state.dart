import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:test_maimaid/presentation/register/models/email.dart';
import 'package:test_maimaid/presentation/register/models/name.dart';

class RegisterState extends Equatable {
  final FormzStatus? status;
  final Name name;
  final Email email;
  final String? nameError;
  final String? emailError;

  const RegisterState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.nameError,
    this.emailError,
  });

  RegisterState copyWith({
    FormzStatus? status,
    Name? name,
    Email? email,
    String? nameError,
    String? emailError,
  }) {
    return RegisterState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      nameError: nameError,
      emailError: emailError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        email,
        nameError,
        emailError,
      ];
}
