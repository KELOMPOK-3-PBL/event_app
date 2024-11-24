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
