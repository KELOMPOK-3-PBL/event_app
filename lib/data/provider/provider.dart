import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/widget/ui_colors.dart';
import '../../data/model/model.dart';
// import '../../data/service/service.dart';

part 'providers/auth_provider.dart';
part 'providers/category_provider.dart';
part 'providers/event_provider.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio(
        BaseOptions(baseUrl: 'http://10.0.2.2:80/api-03/routes' //! set api link
            // BaseOptions(
            //     baseUrl:
            //         'https://testpblpolivent.netlify.app/api-03/routes' //! set api link
            ),
      ));
}
