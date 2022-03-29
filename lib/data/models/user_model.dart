import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class UserModel extends Equatable {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;

  const UserModel({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}
