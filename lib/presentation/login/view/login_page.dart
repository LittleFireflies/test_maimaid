import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:test_maimaid/data/repositories/user_repository_impl.dart';
import 'package:test_maimaid/domain/usecases/login.dart';
import 'package:test_maimaid/presentation/login/bloc/login_bloc.dart';
import 'package:test_maimaid/presentation/login/bloc/login_event.dart';
import 'package:test_maimaid/presentation/login/bloc/login_state.dart';
import 'package:test_maimaid/presentation/register/views/register_page.dart';
import 'package:test_maimaid/utils/widgets/app_button.dart';
import 'package:test_maimaid/utils/widgets/app_text_field.dart';

class LoginPage extends StatelessWidget {
  static const routeName = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        login: Login(
          context.read<UserRepositoryImpl>(),
        ),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        final error = state.loginError;
        if (error != null) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(error),
              dismissDirection: DismissDirection.horizontal,
            ));
        }
        if (state.status.isSubmissionSuccess) {
          // TODO: Open Main page
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Login now to use our awesome apps',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 28.0),
                    const Text('Email'),
                    AppTextField(
                      onChanged: (email) => context
                          .read<LoginBloc>()
                          .add(LoginEmailChanged(email)),
                      textInputType: TextInputType.emailAddress,
                      errorText: state.emailError,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(height: 28.0),
                    const Text('Password'),
                    AppTextField(
                      onChanged: (password) => context
                          .read<LoginBloc>()
                          .add(LoginPasswordChanged(password)),
                      errorText: state.passwordError,
                      prefixIcon: const Icon(Icons.lock),
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                    ),
                    const SizedBox(height: 28.0),
                    const LoginButton(),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.routeName);
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          children: [
                            TextSpan(
                              text: "Register",
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

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AppButton(
          onPressed: () {
            context.read<LoginBloc>().add(const LoginSubmitted());
          },
          inProgress: state.status.isSubmissionInProgress,
          enabled: state.status.isValidated,
          child: const Text('Login'),
        );
      },
    );
  }
}
