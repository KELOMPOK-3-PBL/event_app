import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:event_proposal_app/presentation/widget/ui_colors.dart';
import 'package:event_proposal_app/data/model/model.dart';

part 'repositories/user_repository.dart';
part 'repositories/category_repository.dart';
part 'repositories/auth_repository.dart';
part 'repositories/event_repository.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(
      () => Dio(BaseOptions(baseUrl: 'http://10.0.2.2:80/api-03/routes')));
}
