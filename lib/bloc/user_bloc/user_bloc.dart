import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/model.dart';
import '../../data/repository/repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _userRepository = UserRepository();

  UserBloc() : super(UserInitial()) {
    on<FetchUser>(_onFetchUser);
    on<FetchUserById>(_onFetchUserById);
  }

  Future<void> _onFetchUser(FetchUser event, Emitter<UserState> emit) async {
    // emit(AuthLoading());
    try {
      // debugPrint("fetch user");

      final userData =
          await _userRepository.getUsers(event.searchUser, event.token);
      // debugPrint(userData.toString());
      if (userData.status == 'success') {
        emit(UsersLoaded(listUser: userData.listUserData!));
      } else {
        emit(ErrorUserState(errorMessage: userData.message));
      }
    } catch (error) {
      debugPrint('error model');
      emit(ErrorUserState(errorMessage: error.toString()));
    }
  }

  Future<void> _onFetchUserById(
      FetchUserById event, Emitter<UserState> emit) async {
    // emit(AuthLoading());
    try {
      // debugPrint("fetch user");

      final userData =
          await _userRepository.getUserByUID(event.userId, event.token);
      // debugPrint(userData.toString());
      if (userData.status == 'success') {
        emit(UserByUIDLoaded(userData: userData.userData!));
      } else {
        emit(ErrorUserState(errorMessage: userData.message));
      }
    } catch (error) {
      debugPrint('error model');
      emit(ErrorUserState(errorMessage: error.toString()));
    }
  }
}
