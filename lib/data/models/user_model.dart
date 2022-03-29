import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:test_maimaid/domain/entities/user.dart';

part 'user_model.g.dart';

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

  User toEntity() => User(
        name: this.name,
        email: this.email,
        password: this.password,
      );

  @override
  List<Object?> get props => [name, email, password];
}
