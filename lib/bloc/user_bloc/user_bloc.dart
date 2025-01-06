import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:event_proposal_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/model.dart';
import '../../data/repository/repository.dart';

part 'user_event.dart';
part 'user_state.dart';

int limit = 12;

class UserBloc extends Bloc<UserEvent, UserState> {
  final _userRepository = UserRepository();
  final AuthBloc authBloc;

  UserBloc({required this.authBloc}) : super(UserInitial()) {
    on<FetchUser>(_onFetchUser);
    on<FetchUserById>(_onFetchUserById);
    on<UpdateUser>(_onUpdateUser);
  }

  Future<void> _onFetchUser(FetchUser event, Emitter<UserState> emit) async {
    final authState = authBloc.state;
    if (authState is AuthAuthenticated) {
      final token = authState.authData.accessToken;
      if (state is UsersLoaded && event.isReload == false) {
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
              event.searchUser, token!,
              offset: nextPage, limit: limit);
          debugPrint(newUserData.toString());
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
          debugPrint('Test initial');
          final userData = await _userRepository
              .getUsers(event.searchUser, token!, limit: limit);
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
    } else {
      debugPrint('No Auth');
    }
  }

  Future<void> _onFetchUserById(
      FetchUserById event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final authState = authBloc.state;
    if (authState is AuthAuthenticated) {
      try {
        final token = authState.authData.accessToken;
        final userData =
            await _userRepository.getUserByUID(event.userId, token!);
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
    } else {
      debugPrint('No Auth');
    }
  }

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final authState = authBloc.state;
    debugPrint('Update User');
    if (authState is AuthAuthenticated) {
      try {
        final updateResponse = await _userRepository.updateUserAPI(
          event.userData,
          authState.authData.accessToken!,
          authState.currentRole!,
          authState.authData.data!.userId,
        );
        debugPrint(updateResponse.toString());
        if (updateResponse['status'] == 'success') {
          emit(UserUpdated(updateResponse['message']));
        } else {
          emit(ErrorUserState(errorMessage: updateResponse['message']));
        }
      } catch (error) {
        debugPrint('Error');
        emit(ErrorUserState(errorMessage: error.toString()));
      }
    } else {
      debugPrint('No Auth');
    }
  }

  static value() {}
}
