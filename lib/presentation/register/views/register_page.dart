import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_maimaid/data/repositories/user_repository_impl.dart';
import 'package:test_maimaid/domain/repositories/user_repository.dart';
import 'package:test_maimaid/domain/usecases/register_user.dart';
import 'package:test_maimaid/presentation/register/bloc/register_bloc.dart';
import 'package:test_maimaid/presentation/register/bloc/register_event.dart';
import 'package:test_maimaid/presentation/register/bloc/register_state.dart';
import 'package:test_maimaid/utils/widgets/app_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        registerUser: RegisterUser(
          context.read<UserRepositoryImpl>(),
        ),
      ),
      child: RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Register'),
                Text('Full Name'),
                AppTextField(
                  onChanged: (name) => context
                      .read<RegisterBloc>()
                      .add(RegisterNameChanged(name)),
                  errorText: state.nameError,
                  prefixIcon: const Icon(Icons.person),
                ),
                Text('Email'),
                AppTextField(
                  onChanged: (email) => context
                      .read<RegisterBloc>()
                      .add(RegisterEmailChanged(email)),
                  textInputType: TextInputType.emailAddress,
                  errorText: state.emailError,
                  prefixIcon: const Icon(Icons.email),
                ),
                Text('Password'),
                AppTextField(
                  onChanged: (password) => context
                      .read<RegisterBloc>()
                      .add(RegisterPasswordChanged(password)),
                  errorText: state.passwordError,
                  prefixIcon: const Icon(Icons.lock),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<RegisterBloc>().add(const RegisterSubmitted());
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
