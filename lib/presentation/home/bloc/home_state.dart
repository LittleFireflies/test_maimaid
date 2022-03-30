import 'package:equatable/equatable.dart';
import 'package:test_maimaid/domain/entities/user_data.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class UsersLoadingState extends HomeState {
  const UsersLoadingState();

  @override
  List<Object?> get props => [];
}

class UsersLoadedState extends HomeState {
  final List<UserData> users;

  const UsersLoadedState(this.users);

  @override
  List<Object?> get props => [users];
}

class UsersLoadErrorState extends HomeState {
  final String message;

  const UsersLoadErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
