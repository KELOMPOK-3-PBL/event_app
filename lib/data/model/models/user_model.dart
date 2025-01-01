part of '../model.dart';

class UsersModel extends Equatable {
  final String status;
  final String message;
  final List<UserDataModel>? listUserData;
  final UserDataModel? userData;

  // Constructor
  const UsersModel({
    required this.status,
    required this.message,
    this.listUserData,
    this.userData,
  });

  // Convert a JSON map to the ListUsersModel object
  factory UsersModel.fromJsonforList({required Map<String, dynamic> json}) =>
      UsersModel(
        status: json['status'] ?? '',
        message: json['message'] ?? '',
        listUserData: (json['data'] as List<dynamic>)
            .map((item) => UserDataModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );

  factory UsersModel.fromJsonForSingle({required Map<String, dynamic> json}) =>
      UsersModel(
        status: json['status'],
        message: json['message'],
        userData: UserDataModel.fromJson(json['data'] as Map<String, dynamic>),
      );
  @override
  List<Object?> get props => [status, message, listUserData, userData];
}

class UserDataModel extends Equatable {
  final String? userid;
  final String username;
  final String? email;
  final List<String>? roles;
  final String? about;
  final String? avatarLink;
  final File? avatar;

  // Constructor
  const UserDataModel({
    this.userid,
    required this.username,
    this.email,
    this.roles,
    this.about,
    this.avatarLink,
    this.avatar,
  });

  String? getUserId() {
    return userid;
  }

  UserDataModel removeUnusedDataToInvitePerson() {
    return UserDataModel(
      userid: userid,
      username: username,
      avatarLink: avatarLink,
      roles: null,
      about: null,
      email: null,
      avatar: null,
    );
  }

  // Convert a JSON map to the UserModel object
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userid: json['user_id'].toString(),
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      roles: (json['roles'] != null)
          ? (json['roles'] as String).split(',').map((e) => e.trim()).toList()
          : [],
      about: json['about'],
      avatarLink: json['avatar'],
    );
  }

  Future<FormData> toFormDataChangeRoles() async {
    final Map<String, dynamic> data = {
      'roles': (roles != null || roles != []) ? roles!.join(',') : '',
    };

    // Hapus key dengan nilai null
    data.removeWhere((key, value) => value == null);

    return FormData.fromMap(data);
  }

  Future<FormData> toFormDataEditMyProfile() async {
    final Map<String, dynamic> data = {
      // 'user_id': userid,
      'username': username,
      // 'email': email,
      'avatar':
          (avatar != null) ? await MultipartFile.fromFile(avatar!.path) : null,
      // 'roles': (roles != null || roles != []) ? roles!.join(',') : '',
      'about': about,
    };

    // Hapus key dengan nilai null
    data.removeWhere((key, value) => value == null);

    return FormData.fromMap(data);
  }

  @override
  List<Object?> get props =>
      [userid, username, email, roles, about, avatarLink, avatar];
}
