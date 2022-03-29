import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:test_maimaid/presentation/register/models/name.dart';

class RegisterState extends Equatable {
  final FormzStatus? status;
  final Name? name;
  final String? nameError;

  const RegisterState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.nameError,
  });

  RegisterState copyWith({
    FormzStatus? status,
    Name? name,
    String? nameError,
  }) {
    return RegisterState(
      status: status ?? this.status,
      name: name ?? this.name,
      nameError: nameError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        nameError,
      ];
}
