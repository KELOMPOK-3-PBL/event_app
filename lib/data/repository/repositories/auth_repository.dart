part of '../repository.dart';

// Enum untuk status autentikasi
enum UserPrivilege { superadmin, admin, propose, member }

class AuthRepository {
  // final _controller = StreamController<UserStatus>.broadcast();
  // final dio = getIt<Dio>();
  // final sessionDuration = Duration(days: 1); // Durasi sesi 1 hari
  final authProvider = AuthProvider();

  // AuthRepository({required this.authProvider});

  // Timer? _sessionTimer;

  // AuthRepository() {
  //   loadSessionStatus();
  // }

  // Stream<UserStatus> get status async* {
  //   yield* _controller.stream;
  // }

  // Future<void> loadSessionStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final lastLoginTime = prefs.getInt('lastLoginTime');
  //   final currentTime = DateTime.now().millisecondsSinceEpoch;

  //   if (lastLoginTime != null) {
  //     final isSessionValid =
  //         (currentTime - lastLoginTime) < sessionDuration.inMilliseconds;
  //     if (isSessionValid) {
  //       _controller.add(UserStatus.authenticated);
  //       _startSessionCountdown();
  //     } else {
  //       await logout();
  //     }
  //   } else {
  //     _controller.add(UserStatus.unauthenticated);
  //   }
  // }

  Future<AuthModel> login(
      String email, String password, bool rememberMe) async {
    try {
      // '/authRoutes.php/login'
      // final response = await dio.post('/auth',
      //     options: Options(contentType: 'application/json'),
      //     data: jsonEncode({
      //       'email': email,
      //       'password': password,
      //     }));

      final response = await authProvider.authRequest(email, password);

      final data = response.data;

      if (response.statusCode == 200 && data["status"] == 'success') {
        //! Simpan waktu login dan waktu sesi berakhir
        // await _saveLoginSession();
        // _controller.add(UserStatus.authenticated);
        // _startSessionCountdown();

        // if (rememberMe == true) {
        // _controller.add(UserStatus.unauthenticated);
        saveUserPreferences(email, password, rememberMe);
        // }
        return AuthModel(
            // statusCode: response.statusCode.toString(),
            status: data['status'],
            message: data['message'],
            token: data['token'],
            userId: data['user_id'],
            userName: data['username'],
            roles: data['roles']);
        // return {
        //   'user_id': data['user_id'],
        //   'email': email,
        //   'username': data['username'],
        //   'roles': List<String>.from(
        //       data['roles']), // Konversi roles ke List<String>
        // };
        // return data;
      } else if (data["status"] == 'error') {
        // _controller.add(UserStatus.unauthenticated);
        return AuthModel(
          // statusCode: response.statusCode.toString(),
          status: data['status'],
          message: data['message'],
        );
      } else {
        // _controller.add(UserStatus.unauthenticated);
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('API REQUEST FAILED');
    }
  }

  // Future<String> login(String email, String password, bool rememberMe) async {
  //   await authProvider.authData(email, password);

  //   return data;
  // }

  Future<void> saveUserPreferences(
      String email, String password, bool rememberMe) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (rememberMe == true) {
      await prefs.setBool('rememberMe', rememberMe);
      await prefs.setString('email', email);
      await prefs.setString('password', password);
    } else {
      await prefs.setBool('rememberMe', false);
      await prefs.setString('email', '');
      await prefs.setString('password', '');
    }
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

  // Future<void> logout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  //   _controller.add(UserStatus.unauthenticated);
  //   _stopSessionCountdown();
  // }

  // Future<void> _saveLoginSession() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final currentTime = DateTime.now().millisecondsSinceEpoch;
  //   await prefs.setInt('lastLoginTime', currentTime);
  // }

  // void _startSessionCountdown() {
  //   _sessionTimer?.cancel();
  //   _sessionTimer = Timer(sessionDuration, () async {
  //     await logout(); // logout otomatis setelah durasi sesi habis
  //   });
  // }

  // void _stopSessionCountdown() {
  //   _sessionTimer?.cancel();
  // }

  // void dispose() => _controller.close();
}
