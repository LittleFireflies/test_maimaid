import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_maimaid/data/repositories/user_repository_impl.dart';
import 'package:test_maimaid/domain/usecases/load_users.dart';
import 'package:test_maimaid/presentation/home/bloc/home_bloc.dart';
import 'package:test_maimaid/presentation/home/bloc/home_event.dart';
import 'package:test_maimaid/presentation/home/bloc/home_state.dart';
import 'package:test_maimaid/presentation/user_detail/view/user_detail_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        loadUsers: LoadUsers(
          context.read<UserRepositoryImpl>(),
        ),
      )..add(const LoadUserList()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is UsersLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final user = state.users[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      onTap: () => Navigator.pushNamed(
                        context,
                        UserDetailPage.routeName,
                        arguments: user,
                      ),
                      leading: Image.network(user.avatar),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                    ),
                  );
                },
                itemCount: state.users.length,
              );
            } else if (state is UsersLoadErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
