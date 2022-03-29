import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];
}

class UserAlreadyExistException extends AppException {
  const UserAlreadyExistException({String message = 'User already exist'})
      : super(message);
}

class UserNotFoundException extends AppException {
  const UserNotFoundException({String message = 'User not found'})
      : super(message);
}

class LoginFailedException extends AppException {
  const LoginFailedException(
      {String message = 'Login failed, please check your password'})
      : super(message);
}
