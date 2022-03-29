import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_maimaid/domain/entities/user.dart';
import 'package:test_maimaid/domain/usecases/register_user.dart';
import 'package:test_maimaid/presentation/register/bloc/register_event.dart';
import 'package:test_maimaid/presentation/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUser _registerUser;

  RegisterBloc({required RegisterUser registerUser})
      : _registerUser = registerUser,
        super(const RegisterState()) {
    on<RegisterUserEvent>((event, emit) {
      final user = User(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      _registerUser.execute(user);
    });
  }
}
