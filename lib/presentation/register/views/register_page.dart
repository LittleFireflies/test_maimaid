import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_maimaid/data/repositories/user_repository_impl.dart';
import 'package:test_maimaid/domain/repositories/user_repository.dart';
import 'package:test_maimaid/domain/usecases/register_user.dart';
import 'package:test_maimaid/presentation/register/bloc/register_bloc.dart';
import 'package:test_maimaid/presentation/register/bloc/register_event.dart';

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

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Register'),
              Text('Full Name'),
              TextField(
                controller: _nameController,
              ),
              Text('Email'),
              TextField(
                controller: _emailController,
              ),
              Text('Password'),
              TextField(
                controller: _passwordController,
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<RegisterBloc>().add(
                        RegisterUserEvent(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}