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
  final List<UserModel> listUser;

  const UsersLoaded({required this.listUser});

  @override
  String toString() => 'InUserState $listUser';

  @override
  List<Object> get props => [listUser];
}

class ErrorUserState extends UserState {
  final String errorMessage;

  const ErrorUserState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
