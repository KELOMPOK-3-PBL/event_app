part of '../repository.dart';

// Enum untuk cek role
// enum UserPrivilege { superadmin, admin, propose, member }

class UserRepository {
  final userProvider = UserProvider();

  Future<ListUsersModel> getUsers(String? searchUser, String token) async {
    try {
      // debugPrint("getUsers");
      final response = await userProvider.getUsersAPI(searchUser, token);
      final data = response.data;
      // debugPrint(response.data.toString());
      if (response.statusCode == 200 && data["status"] == 'success') {
        return ListUsersModel.fromJson(json: data);
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
