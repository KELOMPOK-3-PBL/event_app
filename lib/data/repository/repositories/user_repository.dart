part of '../repository.dart';

enum UserStatus { unknown, authenticated, unauthenticated }

class UserRepository {
  final dio = getIt<Dio>();

  final _controller = StreamController<UserStatus>();

  Stream<UserStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield UserStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<Map<String, dynamic>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post('/authRoutes.php/login',
          options: Options(contentType: 'application/json'),
          data: jsonEncode({'email': email, 'password': password}));

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'success') {
          _controller.add(UserStatus.authenticated);
          return {
            'message': data['message'],
            'responseCode': response.statusCode,
            'email': email,
            'role': data['role'],
          };
        } else {
          _controller.add(UserStatus.unauthenticated);
          return {
            'message': data['message'] ?? 'Userentication failed',
            'responseCode': response.statusCode,
          };
        }
      } else {
        _controller.add(UserStatus.unauthenticated);
        return {
          'message': 'Failed to authenticate',
          'responseCode': response.statusCode,
        };
      }
    } on DioException catch (e) {
      _controller.add(UserStatus.unauthenticated);
      String errorMessage = e.response?.data['message'] ?? e.message;
      return {
        'message': 'Error: $errorMessage',
        'responseCode': e.response?.statusCode ?? 500,
      };
    }
  }

  void logOut() {
    _controller.add(UserStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
