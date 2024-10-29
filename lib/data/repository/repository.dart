import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/widget/ui_colors.dart';
import '../../data/model/model.dart';
// import '../../data/service/service.dart';

part 'repositories/auth_repository.dart';
part 'repositories/category_repository.dart';
part 'repositories/event_repository.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio(
        //! set api link
        // 'http://10.0.2.2:80/api-03/routes'
        BaseOptions(baseUrl: 'https://polivent.my.id/api'),
      ));
}
