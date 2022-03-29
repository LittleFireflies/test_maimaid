import 'package:formz/formz.dart';

enum PasswordInputError { empty }

class Password extends FormzInput<String, PasswordInputError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordInputError? validator(String value) {
    return value.isEmpty ? PasswordInputError.empty : null;
  }
}
