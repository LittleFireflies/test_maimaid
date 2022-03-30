import 'package:dio/dio.dart';

class AppDioError extends DioError {
  final String errorMessage;

  int get status => response?.statusCode ?? 0;

  AppDioError._(DioError err, this.errorMessage)
      : super(
          requestOptions: err.requestOptions,
          error: err.error,
          response: err.response,
          type: err.type,
        );

  @override
  String toString() => errorMessage;

  factory AppDioError.fromError({
    required DioError err,
    required String errorMessage,
  }) =>
      AppDioError._(err, errorMessage);
}
