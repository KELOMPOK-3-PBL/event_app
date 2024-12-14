import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../model/model.dart';

//! PROVIDER : Digunakan untuk mengirim dan menerima data raw(Belum Diolah) dari API

part 'providers/auth_provider.dart';
part 'providers/category_provider.dart';
part 'providers/event_provider.dart';
part 'providers/user_provider.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // getIt.registerLazySingleton<Dio>(() => Dio(
  //       //! set api link
  //       BaseOptions(baseUrl: 'https://polivent.my.id/api'),
  //     ));
  getIt.registerLazySingleton<Dio>(() => Dio(
        //! set api link
        BaseOptions(
          baseUrl: 'http://10.0.2.2:80/api-03/routes',
          // baseUrl: 'http://192.168.110.131/api-03/routes',
          // baseUrl: 'https://polivent.my.id/api',
          contentType: 'application/json',
          // persistentConnection: true,
          preserveHeaderCase: true,
          // connectTimeout: Duration(minutes: 1)
        ),
      ));
}
