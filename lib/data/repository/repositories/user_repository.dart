part of '../repository.dart';

// Enum untuk cek role
// enum UserPrivilege { superadmin, admin, propose, member }

class UserRepository {
  final userProvider = UserProvider();

  Future<UsersModel> getUsers(String? searchUser, String token,
      {int offset = 0, required int limit}) async {
    try {
      // debugPrint("getUsers");
      final response = await userProvider.getUsersAPI(
          searchUser: searchUser, token: token, offset: offset, limit: limit);
      final data = response.data;
      // debugPrint("response ${data.toString()}");
      if (response.statusCode == 200) {
        return UsersModel.fromJsonforList(json: data);
        // } else if (response.statusCode == 404 || data["status"] == 'error') {
        //   return EventModel.fromJson(json: data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('error users model');
      throw Exception('API REQUEST FAILED');
    }
  }

  Future<UsersModel> getUserByUID(String userId, String token) async {
    try {
      // debugPrint("getUsers");
      final response =
          await userProvider.getUsersAPI(userId: userId, token: token);
      final data = response.data;
      if (response.statusCode == 200 && data["status"] == 'success') {
        final UsersModel userModel = UsersModel.fromJsonForSingle(json: data);
        // debugPrint('User Model: $userModel');
        return userModel;
        // return UsersModel.fromJsonForSingle(json: data);
        // } else if (response.statusCode == 404 || data["status"] == 'error') {
        //   return EventModel.fromJson(json: data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('API REQUEST FAILED');
    }
  }
}
