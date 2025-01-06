part of '../provider.dart';

class UserProvider {
  final dio = getIt<Dio>();

  Future<Response> getUsersAPI({
    String? userId,
    String? searchUser,
    required String token,
    int? offset,
    int? limit,
  }) async {
    try {
      final queryParameters = {
        'query': searchUser,
        'user_id': userId,
        'offset': offset,
        'limit': limit,
      } // Menyederhanakan fungsi
        ..removeWhere((key, value) =>
            value == null); // Menghapus parameter yang bernilai null
      dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      dio.options.headers[HttpHeaders.cookieHeader] = "jwt=$token";
      dio.options.contentType = "application/json";

      // request get ke API
      final Response rawResponse = await dio.get(
        '/users',
        queryParameters: queryParameters,
      );

      // Gunakan logging untuk melihat apakah header Authorization dikirim dengan benar
      // dio.interceptors
      //     .add(LogInterceptor(responseBody: true, requestBody: true));

      return rawResponse;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> chekLogin({required String token}) async {
    try {
      dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      dio.options.headers[HttpHeaders.cookieHeader] = "jwt=$token";
      dio.options.contentType = "application/json";

      // request get ke API
      final Response rawResponse = await dio.get(
        '/auth',
      );

      // Gunakan logging untuk melihat apakah header Authorization dikirim dengan benar
      // dio.interceptors
      //     .add(LogInterceptor(responseBody: true, requestBody: true));

      return rawResponse;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> updateUser({
    required UserDataModel userData,
    required String token,
    required String currentUser,
    required String userIdWhoEditing,
  }) async {
    try {
      late FormData formUserData;
      final String editedUserId = userData.getUserId()!;

      if (editedUserId == userIdWhoEditing) {
        debugPrint('Update Profile');
        formUserData = await userData.toFormDataEditMyProfile();
      } else if (currentUser == 'Superadmin' &&
          editedUserId != userIdWhoEditing) {
        debugPrint('Update Roles');
        formUserData = await userData.toFormDataChangeRoles();
      }

      final Response rawResponse = await dio.post(
        '/users',
        queryParameters: {'user_id': editedUserId},
        data: formUserData,
      );

      return rawResponse;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
