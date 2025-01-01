part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUser extends UserEvent {
  final String? searchUser;
  final String? userId;
  final String? sort;
  final String? order;
  final String? role;
  final bool isReload;
  // final String? token;

  FetchUser({
    this.sort,
    this.order,
    this.role,
    this.searchUser,
    this.userId,
    this.isReload = false,
    // this.token,
  });

  @override
  List<Object> get props => [searchUser!];
}

class FetchUserById extends UserEvent {
  final String userId;
  // final String token;

  FetchUserById({
    // required this.token,
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class UpdateUser extends UserEvent {
  final UserDataModel userData;

  UpdateUser({required this.userData});

  @override
  List<Object> get props => [userData];
}
