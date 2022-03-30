import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadUserList extends HomeEvent {
  const LoadUserList();

  @override
  List<Object?> get props => [];
}
