import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_maimaid/data/repositories/user_repository_impl.dart';
import 'package:test_maimaid/domain/usecases/register_user.dart';
import 'package:test_maimaid/presentation/register/bloc/register_bloc.dart';
import 'package:test_maimaid/presentation/register/bloc/register_event.dart';
import 'package:test_maimaid/presentation/register/bloc/register_state.dart';
import 'package:test_maimaid/utils/widgets/app_button.dart';
import 'package:test_maimaid/utils/widgets/app_text_field.dart';
import 'package:formz/formz.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = 'register';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        registerUser: RegisterUser(
          context.read<UserRepositoryImpl>(),
        ),
      ),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        final error = state.registerError;
        if (error != null) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(error),
              dismissDirection: DismissDirection.horizontal,
            ));
        }
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
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
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Create an account to access all the features on our apps',
                      style: TextStyle(fontSize: 16.0),
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
                    const RegisterButton(),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          children: [
                            TextSpan(
                              text: "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AppButton(
          onPressed: () {
            context.read<RegisterBloc>().add(const RegisterSubmitted());
          },
          inProgress: state.status.isSubmissionInProgress,
          enabled: state.status.isValidated,
          child: const Text('Register'),
        );
      },
    );
  }
}
