import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:test_maimaid/domain/entities/user.dart';
import 'package:test_maimaid/domain/usecases/register_user.dart';
import 'package:test_maimaid/presentation/register/bloc/register_event.dart';
import 'package:test_maimaid/presentation/register/bloc/register_state.dart';
import 'package:test_maimaid/presentation/register/models/name.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser _registerUser;

  RegisterBloc({required RegisterUser registerUser})
      : _registerUser = registerUser,
        super(const RegisterState()) {
    on<RegisterNameChanged>((event, emit) {
      final name = Name.dirty(value: event.name);

      emit(
        state.copyWith(
          name: name,
          status: Formz.validate([name]),
          nameError: name.invalid ? 'Name can not be empty!' : null,
        ),
      );
    });
    on<RegisterSubmitted>((event, emit) {
      final user = User(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      _registerUser.execute(user);
    });
  }
}
