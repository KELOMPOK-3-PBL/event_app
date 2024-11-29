part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUser extends UserEvent {
  final String? searchUser;
  final String token;

  FetchUser({this.searchUser, required this.token});
}

class FetchUserById extends UserEvent {
  final String userId;
  final String token;

  FetchUserById({required this.token, required this.userId});
}
