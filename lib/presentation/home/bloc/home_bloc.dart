import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_maimaid/domain/usecases/load_users.dart';
import 'package:test_maimaid/presentation/home/bloc/home_event.dart';
import 'package:test_maimaid/presentation/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadUsers _loadUsers;

  HomeBloc({required LoadUsers loadUsers})
      : _loadUsers = loadUsers,
        super(const UsersLoadingState()) {
    on<LoadUserList>((event, emit) async {
      try {
        emit(const UsersLoadingState());

        final users = await _loadUsers.execute();
        emit(UsersLoadedState(users));
      } catch (e) {
        emit(UsersLoadErrorState(e.toString()));
      }
    });
  }
}
