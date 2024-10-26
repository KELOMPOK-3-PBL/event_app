part of '../repository.dart';

enum UserStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final _controller = StreamController<UserStatus>();
  final authService = AuthService();

  // AuthRepository(this.authService);

  Stream<UserStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield UserStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<Map<String, dynamic>> signin(
      String email, String password, bool rememberMe) async {
    final response = await authService.login(email, password);

    if (rememberMe) {
      saveUserPreferences(email, password);
    }

    return response;
  }

  // Future<Map<String, dynamic>> logIn({
  //   required String email,
  //   required String password,
  //   required bool rememberMe,
  // }) async {
  //   try {
  //     await Future.delayed(Duration(seconds: 1));
  //     final response = await dio.post('/authRoutes.php/login',
  //         options: Options(contentType: 'application/json'),
  //         data: jsonEncode({'email': email, 'password': password}));

  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       if (data['status'] == 'success') {
  //         _controller.add(UserStatus.authenticated);
  //         if (rememberMe == true) {
  //           saveUserPreferences(email, password);
  //         }
  //         return {
  //           'responseCode': response.statusCode,
  //           'status': data['status'],
  //           'message': data['message'],
  //           'user_id': data['user_id'],
  //           'email': email,
  //           'username': data['username'],
  //           'roles': data['roles'],
  //         };
  //       } else {
  //         _controller.add(UserStatus.unauthenticated);
  //         return {
  //           'message': data['message'] ?? 'Userentication failed',
  //           'responseCode': response.statusCode,
  //         };
  //       }
  //     } else {
  //       _controller.add(UserStatus.unauthenticated);
  //       return {
  //         'message': 'Failed to authenticate',
  //         'responseCode': response.statusCode,
  //       };
  //     }
  //   } on DioException catch (e) {
  //     _controller.add(UserStatus.unauthenticated);
  //     String errorMessage = e.response?.data['message'] ?? e.message;
  //     return {
  //       'message': 'Error: $errorMessage',
  //       'responseCode': e.response?.statusCode ?? 500,
  //     };
  //   }
  // }

  // Future<Map<String, dynamic>> login(
  //     String email, String password, bool rememberMe) async {
  //   // try {
  //   await Future.delayed(Duration(seconds: 1)); // Simulate network delay
  //   final response = await dio.post('/authRoutes.php/login',
  //       options: Options(contentType: 'application/json'),
  //       data: jsonEncode({
  //         'email': email,
  //         'password': password,
  //       }));
  //   if (response.statusCode == 200 && response.data["status"] == 'success') {
  //     if (rememberMe == true) {
  //       saveUserPreferences(email, password);
  //     }
  //     return response.data;
  //   } else {
  //     throw Exception('Error: ${response.statusCode}');
  //   }
  // } catch (error) {
  //   throw Exception('API NOT FOUND');
  // }
// }

  Future<void> saveUserPreferences(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', true);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<UserPreferencesModel> loadUserPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? rememberMe = prefs.getBool('rememberMe');
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    return UserPreferencesModel(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }

  void logOut() {
    _controller.add(UserStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
