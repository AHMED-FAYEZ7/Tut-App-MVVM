import 'package:advance_course_flutter/app/app.dart';
import 'package:advance_course_flutter/app/di.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}

