part of '../repository.dart';

// Enum untuk cek role
// enum UserPrivilege { superadmin, admin, propose, member }

class AuthRepository {
  final authProvider = AuthProvider();

  Future<AuthModel> login(
      String email, String password, bool rememberMe) async {
    try {
      final response = await authProvider.authRequest(email, password);

      final data = response.data;

      if (response.statusCode == 200 && data["status"] == 'success') {
        //! Simpan waktu login dan waktu sesi berakhir
        saveUserPreferences(email, password, rememberMe);
        saveToken(data['data']['token']);
        final payload = await decodeToken(data['data']['token']);
        return AuthModel.fromJson(json: data, payload: payload);
      } else if (response.statusCode == 404 || data["status"] == 'error') {
        return AuthModel.fromJson(json: data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('API REQUEST FAILED');
    }
  }

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

  Future<JwtPayloadModel> decodeToken(String token) async {
    final jwt = JWT.verify(token, SecretKey('pblpolivent'));
    final data = jwt.payload;

    return JwtPayloadModel.fromJson(data);
  }

  Future<void> saveToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token ?? '');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Future<void> checkAuthentication() async {
  //   final token = await getToken();
  //   if (token != null) {
  //     // Verifikasi atau decode token untuk memeriksa validitasnya
  //     try {
  //       final jwt = JWT.verify(token, SecretKey('pblpolivent'));
  //       // Token valid, user bisa diarahkan ke home screen
  //     } catch (e) {
  //       // Token tidak valid, navigasikan ke login
  //     }
  //   } else {
  //     // Token tidak ada, navigasikan ke login
  //   }
  // }

  // Future<void> logout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  //   _controller.add(UserStatus.unauthenticated);
  //   _stopSessionCountdown();
  // }

  // void dispose() => _controller.close();
}
