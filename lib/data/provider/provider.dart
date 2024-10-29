import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

//! PROVIDER : Digunakan untuk mengirim dan menerima data raw(Belum Diolah) dari API

part 'providers/auth_provider.dart';
part 'providers/category_provider.dart';
part 'providers/event_provider.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio(
        //! set api link
        // 'http://10.0.2.2:80/api-03/routes'
        BaseOptions(baseUrl: 'https://polivent.my.id/api'),
      ));
}
