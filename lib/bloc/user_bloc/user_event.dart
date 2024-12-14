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
  final String token;

  FetchUser({
    this.sort,
    this.order,
    this.role,
    this.searchUser,
    this.userId,
    required this.token,
  });

  @override
  List<Object> get props => [searchUser!, token];
}

class FetchUserById extends UserEvent {
  final String userId;
  final String token;

  FetchUserById({required this.token, required this.userId});

  @override
  List<Object> get props => [userId, token];
}

class ReloadFetchUserById extends UserEvent {
  final String userId;
  final String token;

  ReloadFetchUserById({required this.token, required this.userId});

  @override
  List<Object> get props => [userId, token];
}
