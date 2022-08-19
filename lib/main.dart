import 'package:advance_course_flutter/app/app.dart';
import 'package:advance_course_flutter/app/di.dart';
import 'package:advance_course_flutter/data/network/app_api.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}

