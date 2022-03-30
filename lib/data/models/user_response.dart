import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test_maimaid/data/models/user_data_dto.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse extends Equatable {
  @JsonKey(name: 'page')
  final int page;
  @JsonKey(name: 'per_page')
  final int perPage;
  @JsonKey(name: 'total')
  final int total;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'data')
  final List<UserDataDto> data;

  const UserResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  @override
  List<Object?> get props => [
        page,
        perPage,
        total,
        totalPages,
        data,
      ];
}
