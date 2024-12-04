part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

/// Initialized
class UsersLoaded extends UserState {
  final List<UserDataModel> listUser;
  final String? searchUser;
  final bool hasReachedMax;

  const UsersLoaded({
    this.searchUser,
    required this.hasReachedMax,
    required this.listUser,
  });

  @override
  List<Object> get props => [listUser, hasReachedMax];
}

class UserByUIDLoaded extends UserState {
  final UserDataModel userData;

  const UserByUIDLoaded({required this.userData});

  @override
  String toString() => 'InUserState $userData';

  @override
  List<Object> get props => [userData];
}

class ErrorUserState extends UserState {
  final String errorMessage;

  const ErrorUserState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
