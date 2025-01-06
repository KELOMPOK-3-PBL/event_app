import 'dart:async';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/provider/provider.dart';
import '../../data/model/model.dart';

//! REPOSITORY : Digunakan untuk mengolah data mentah yang diambil dari PROVIDER
//!              ke dalam MODEL dan menghubungkannya ke BLoC Layer

part 'repositories/auth_repository.dart';
part 'repositories/category_repository.dart';
part 'repositories/event_repository.dart';
part 'repositories/user_repository.dart';
