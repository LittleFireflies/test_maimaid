import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_maimaid/data/repositories/user_repository_impl.dart';
import 'package:test_maimaid/domain/repositories/user_repository.dart';
import 'package:test_maimaid/domain/usecases/register_user.dart';
import 'package:test_maimaid/presentation/register/bloc/register_bloc.dart';
import 'package:test_maimaid/presentation/register/bloc/register_event.dart';
import 'package:test_maimaid/presentation/register/bloc/register_state.dart';
import 'package:test_maimaid/utils/widgets/app_text_field.dart';
import 'package:formz/formz.dart';

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
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 28.0),
                  const Text('Full Name'),
                  AppTextField(
                    onChanged: (name) => context
                        .read<RegisterBloc>()
                        .add(RegisterNameChanged(name)),
                    errorText: state.nameError,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  const SizedBox(height: 28.0),
                  const Text('Email'),
                  AppTextField(
                    onChanged: (email) => context
                        .read<RegisterBloc>()
                        .add(RegisterEmailChanged(email)),
                    textInputType: TextInputType.emailAddress,
                    errorText: state.emailError,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  const SizedBox(height: 28.0),
                  const Text('Password'),
                  AppTextField(
                    onChanged: (password) => context
                        .read<RegisterBloc>()
                        .add(RegisterPasswordChanged(password)),
                    errorText: state.passwordError,
                    prefixIcon: const Icon(Icons.lock),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                  ),
                  const SizedBox(height: 28.0),
                  AppButton(
                    onPressed: () {
                      context
                          .read<RegisterBloc>()
                          .add(const RegisterSubmitted());
                    },
                    inProgress: state.status.isSubmissionInProgress,
                    enabled: state.status.isValidated,
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;
  final bool inProgress;
  final Widget child;

  const AppButton({
    Key? key,
    required this.onPressed,
    this.enabled = true,
    this.inProgress = true,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        minimumSize: const Size.fromHeight(44.0),
      ),
      onPressed: enabled && !inProgress ? onPressed : null,
      child: inProgress ? const CircularProgressIndicator() : child,
    );
  }
}
