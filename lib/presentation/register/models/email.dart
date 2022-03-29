import 'package:formz/formz.dart';

enum EmailInputError { empty, invalidFormat }

class Email extends FormzInput<String, EmailInputError> {
  const Email.pure() : super.pure('');

  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailInputError? validator(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (value.isEmpty) {
      return EmailInputError.empty;
    } else if (!emailValid) {
      return EmailInputError.invalidFormat;
    } else {
      return null;
    }
  }
}
