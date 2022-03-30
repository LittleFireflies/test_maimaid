import 'dart:async';

import 'package:dio/dio.dart';
import 'package:test_maimaid/data/models/user_response.dart';

abstract class RemoteDataSource {
  Future<UserResponse> getUsers();
}

class ApiService extends RemoteDataSource {
  final Dio _dioClient;

  ApiService(Dio dio) : _dioClient = dio;

  static const baseUrl = 'https://reqres.in/api';

  @override
  Future<UserResponse> getUsers() async {
    final response = await _dioClient.get('$baseUrl/users');

    return UserResponse.fromJson(response.data);
  }
}
