import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:test_maimaid/domain/entities/user.dart';
import 'package:test_maimaid/domain/usecases/register_user.dart';
import 'package:test_maimaid/presentation/register/bloc/register_event.dart';
import 'package:test_maimaid/presentation/register/bloc/register_state.dart';
import 'package:test_maimaid/presentation/register/models/email.dart';
import 'package:test_maimaid/presentation/register/models/name.dart';
import 'package:test_maimaid/presentation/register/models/password.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser _registerUser;

  RegisterBloc({required RegisterUser registerUser})
      : _registerUser = registerUser,
        super(const RegisterState()) {
    on<RegisterNameChanged>(
      (event, emit) => _onRegisterNameChanged(event, emit),
    );
    on<RegisterEmailChanged>(
      (event, emit) => _onRegisterEmailChanged(event, emit),
    );
    on<RegisterPasswordChanged>(
      (event, emit) => _onRegisterPasswordChanged(event, emit),
    );
    on<RegisterSubmitted>((event, emit) {
      // final user = User(
      //   name: event.name,
      //   email: event.email,
      //   password: event.password,
      // );
      // _registerUser.execute(user);
    });
  }

  void _onRegisterNameChanged(
    RegisterNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final name = Name.dirty(value: event.name);

    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([name, state.email]),
        nameError: name.invalid ? 'Name can not be empty!' : null,
      ),
    );
  }

  void _onRegisterEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(value: event.email);

    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.name]),
        emailError: _getEmailError(email.error),
      ),
    );
  }

  void _onRegisterPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(value: event.password);

    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password, state.name, state.email]),
        passwordError: password.invalid ? 'Password can not be empty' : null,
      ),
    );
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
}
