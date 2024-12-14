import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/model.dart';
import '../../data/repository/repository.dart';

part 'user_event.dart';
part 'user_state.dart';

int limit = 10;

class UserBloc extends Bloc<UserEvent, UserState> {
  final _userRepository = UserRepository();

  UserBloc() : super(UserInitial()) {
    on<FetchUser>(_onFetchUser);
    on<FetchUserById>(_onFetchUserById);
    on<ReloadFetchUserById>(_onReloadFetchUserById);
  }

  Future<void> _onFetchUser(FetchUser event, Emitter<UserState> emit) async {
    if (state is UsersLoaded) {
      try {
        final currentState = state as UsersLoaded;

        // Cek apakah semua data sudah termuat
        if (currentState.hasReachedMax) {
          debugPrint("All users loaded");
          return;
        }

        // Ambil data berikutnya berdasarkan indeks halaman saat ini
        final nextPage = currentState.listUser.length;
        debugPrint(nextPage.toString());
        final newUserData = await _userRepository.getUsers(
            event.searchUser, event.token,
            offset: nextPage, limit: limit);

        if (newUserData.status == 'success' &&
                newUserData.listUserData!.isEmpty ||
            newUserData.listUserData!.length < limit) {
          // Emit state dengan data gabungan
          emit(UsersLoaded(
            listUser: currentState.listUser + newUserData.listUserData!,
            searchUser: event.searchUser,
            hasReachedMax: true,
          ));
        } else {
          emit(UsersLoaded(
            listUser: currentState.listUser + newUserData.listUserData!,
            searchUser: event.searchUser,
            hasReachedMax: false,
          ));
        }
      } catch (error) {
        emit(ErrorUserState(errorMessage: error.toString()));
      }
    } else {
      // Jika ini adalah permintaan pertama
      try {
        emit(UserLoading());

        final userData = await _userRepository
            .getUsers(event.searchUser, event.token, limit: limit);
        debugPrint(userData.toString());
        if (userData.listUserData!.length < limit) {
          emit(UsersLoaded(
            listUser: userData.listUserData!,
            searchUser: event.searchUser,
            hasReachedMax: true,
          ));
        } else {
          emit(UsersLoaded(
            listUser: userData.listUserData!,
            searchUser: event.searchUser,
            hasReachedMax: false,
          ));
        }
      } catch (error) {
        emit(ErrorUserState(errorMessage: error.toString()));
      }
    }
  }

  Future<void> _onFetchUserById(
      FetchUserById event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      debugPrint("fetch user");

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

  Future<void> _onReloadFetchUserById(
      ReloadFetchUserById event, Emitter<UserState> emit) async {
    // emit(UserLoading());
    try {
      debugPrint("fetch user");

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

  static value() {}
}
