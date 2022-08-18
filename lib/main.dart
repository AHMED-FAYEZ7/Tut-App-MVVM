import 'package:advance_course_flutter/app/app.dart';
import 'package:advance_course_flutter/data/network/app_api.dart';
import 'package:flutter/material.dart';

void main() {
  AppServicesClient.init();
  runApp(MyApp());
}

