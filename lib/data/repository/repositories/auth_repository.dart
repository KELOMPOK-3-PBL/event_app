part of '../repository.dart';

// Enum untuk cek role
// enum UserPrivilege { superadmin, admin, propose, member }

class AuthRepository {
  final authProvider = AuthProvider();
  final secureStorage = FlutterSecureStorage(); // Untuk menyimpan token

  Future<AuthModel> login(
      String email, String password, bool rememberMe) async {
    final response = await authProvider.authRequest(email, password);
    final data = response.data;
    JwtPayloadModel? payload;
    String? accessToken;
    String? refreshToken;
    // debugPrint(response.toString());

    try {
      if (data["status"] == 'success') {
        //! Simpan waktu login dan waktu sesi berakhir
        saveUserPreferences(email, password, rememberMe);
        // saveToken(data['data']['token']);
        // token = data['data']['token'];
        accessToken = data['data']['access_token'];
        refreshToken = data['data']['refresh_token'];

        saveToken(accessToken!, refreshToken!);

        payload = await decodeToken(accessToken);
      }
      return AuthModel.fromJson(
          json: data,
          accessToken: accessToken,
          refreshToken: refreshToken,
          payload: payload);
      // }
    } catch (_) {
      return AuthModel.fromJson(json: data);
    }
  }

  Future<bool> isAccessTokenValid(int issuedAt, int expiry) async {
    try {
      // Konversi ke `DateTime`
      final issuedAtDate = DateTime.fromMillisecondsSinceEpoch(issuedAt * 1000);
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);

      // Periksa validitas berdasarkan waktu saat ini
      final now = DateTime.now();

      // Token valid jika saat ini antara `issuedAt` dan `expiry`
      if (now.isAfter(issuedAtDate) && now.isBefore(expiryDate)) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
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
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }

  Future<void> saveCurrentRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_role', role);
  }

  Future<String?> getCurretRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_role');
  }

  Future<UserPreferencesModel> getRememberMeUserPref() async {
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

  Future<void> saveToken(String accessToken, String refreshToken) async {
    // final prefs = await SharedPreferences.getInstance();
    secureStorage.write(key: 'access_token', value: accessToken);
    secureStorage.write(key: 'refresh_token', value: refreshToken);
    // await prefs.setString('access_token', token);
  }

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: 'refresh_token');
  }

  Future<AuthModel?> checkAuthentication() async {
    // Verifikasi atau decode token untuk memeriksa validitasnya
    try {
      String? token = await getAccessToken();
      if (token == null) {
        return AuthModel(
          status: "error",
          message: "Token not found",
        );
      }
      final data = await decodeToken(token);
      // Ambil nilai `iat` dan `exp` dalam bentuk integer
      final issuedAt = data.issuedAt;
      final expiry = data.expiration;

      //! Buat pengecekan TOKEN disini
      bool isAuthValid = await isAccessTokenValid(issuedAt, expiry);

      if (isAuthValid == true) {
        final authData = AuthModel(
            status: "success",
            message: "Login data with token succes",
            accessToken: token,
            data: data);
        return authData;
      } else {
        //! Buat fungsi refresh token disini
        final refreshToken = await getRefreshToken();
        final responseRefreshToken =
            await authProvider.refreshToken(refreshToken!);

        final newAccessToken = responseRefreshToken.data['token'];
        // save new token
        secureStorage.write(key: 'access_token', value: newAccessToken);

        final newData = await decodeToken(newAccessToken);

        return AuthModel(
            status: "success",
            message: "Refresh token success",
            accessToken: newAccessToken,
            refreshToken: refreshToken,
            data: newData);
      }
    } catch (e) {
      //! Nanti buat catch mengembalikan Excemtion not found
      Exception("Token Not Found");
      return null;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('access_token');
    await prefs.remove('current_role');
    await secureStorage.delete(key: 'access_token');
    await secureStorage.delete(key: 'refresh_token');

    // await prefs.setString('access_token', '');
    // await prefs.setString('current_role', '');
  }
}
