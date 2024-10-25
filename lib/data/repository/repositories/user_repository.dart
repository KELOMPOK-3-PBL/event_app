import 'dart:async';
import 'package:dio/dio.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final _controller = StreamController<AuthStatus>();
  final Dio dio;
  final String apiUrl;

  AuthRepository({
    required this.apiUrl,
    Dio? dioClient,
  }) : dio = dioClient ?? Dio();

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<Map<String, dynamic>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '$apiUrl/authenticate',
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'success') {
          _controller.add(AuthStatus.authenticated);
          return {
            'message': data['message'],
            'responseCode': response.statusCode,
            'email': email,
            'role': data['role'],
          };
        } else {
          _controller.add(AuthStatus.unauthenticated);
          return {
            'message': data['message'] ?? 'Authentication failed',
            'responseCode': response.statusCode,
          };
        }
      } else {
        _controller.add(AuthStatus.unauthenticated);
        return {
          'message': 'Failed to authenticate',
          'responseCode': response.statusCode,
        };
      }
    } on DioException catch (e) {
      _controller.add(AuthStatus.unauthenticated);
      String errorMessage = e.response?.data['message'] ?? e.message;
      return {
        'message': 'Error: $errorMessage',
        'responseCode': e.response?.statusCode ?? 500,
      };
    }
  }

  void logOut() {
    _controller.add(AuthStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
