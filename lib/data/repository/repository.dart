import 'dart:async';
// import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/widget/ui_colors.dart';
import '../../data/provider/provider.dart';
import '../../data/model/model.dart';

//! REPOSITORY : Digunakan untuk mengolah data mentah yang diambil dari PROVIDER
//!              ke DALAM model dan menghubungkannya ke BLoC

part 'repositories/auth_repository.dart';
part 'repositories/category_repository.dart';
part 'repositories/event_repository.dart';
